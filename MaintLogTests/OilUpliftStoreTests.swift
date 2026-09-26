import Foundation
import SwiftData
import Testing
@testable import MaintLog

@MainActor
struct OilUpliftStoreTests {
    private func fixture() throws -> (ModelContainer, ModelContext, MaintLogDataModel) {
        let container = try ModelContainer(
            for: MaintLogDataModel.self, CustomerDataModel.self,
            OilUpliftDataModel.self, OilUpliftEntriesDataModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = ModelContext(container)
        context.autosaveEnabled = false
        let log = MaintLogDataModel(
            id: UUID(), mainLogNumber: "TEST-001", departurePreviousAirport: "KRK",
            arrivalPreviousAirport: "WAW", flightNumberPreviousFlight: "TEST",
            aircraftRegistration: "SP-TEST", aircraftType: "B737",
            aircraftSubType: "800", referenceNo: "TEST", station: "WAW", status: "OPEN"
        )
        context.insert(log)
        try context.save()
        return (container, context, log)
    }

    @Test func savesCompleteFormAndRelationships() throws {
        let (container, context, log) = try fixture()
        let drafts = [
            OilEntryDraft(system: .eng1, quantity: 2, unit: .usQuard),
            OilEntryDraft(system: .hyd1, quantity: 0.5, unit: .litres)
        ]
        try OilUpliftStore.saveNew(
            for: log, entries: drafts, notes: "Test notes", requireInspection: true,
            author: " mechanic ", in: context
        )

        // Odczyt z nowego kontekstu potwierdza zapis, a nie tylko zmianę obiektów w pamięci.
        let reader = ModelContext(container)
        let storedLog = try #require(reader.fetch(FetchDescriptor<MaintLogDataModel>()).first)
        let uplift = try #require(storedLog.oilUplift)
        #expect(storedLog.status == "OPEN")
        #expect(storedLog.hasOilUplift == true)
        #expect(uplift.notes == "Test notes")
        #expect(uplift.requireInspection)
        #expect(uplift.createdBy == "mechanic")
        #expect(uplift.performInspectioAt == nil)
        #expect(uplift.maintLog.map(\.id) == [storedLog.id])
        #expect(Set(uplift.entries.map(\.id)) == Set(drafts.map(\.id)))
        #expect(uplift.entries.allSatisfy { $0.oiluplift?.id == uplift.id })
        #expect(uplift.entries.contains { $0.system == "HYD1" && $0.quantity == 0.5 && $0.unit == "L" })
    }

    @Test func rejectsInvalidFormWithoutChangingLog() throws {
        let (_, context, log) = try fixture()
        for quantity in [0.0, -1.0, Double.nan, Double.infinity] {
            #expect(throws: OilUpliftStore.SaveError.self) {
                try OilUpliftStore.saveNew(
                    for: log,
                    entries: [OilEntryDraft(system: .eng1, quantity: quantity, unit: .usQuard)],
                    notes: "", requireInspection: false, author: "mechanic", in: context
                )
            }
        }
        #expect(log.oilUplift == nil)
        #expect(!context.hasChanges)
    }

    @Test func doesNotOverwriteExistingUplift() throws {
        let (_, context, log) = try fixture()
        let entries = [OilEntryDraft(system: .apu, quantity: 1, unit: .usQuard)]
        try OilUpliftStore.saveNew(
            for: log, entries: entries, notes: "Original", requireInspection: false,
            author: "mechanic", in: context
        )
        #expect(throws: OilUpliftStore.SaveError.self) {
            try OilUpliftStore.saveNew(
                for: log, entries: entries, notes: "Replacement", requireInspection: true,
                author: "other", in: context
            )
        }
        #expect(log.oilUplift?.notes == "Original")
        #expect(try context.fetchCount(FetchDescriptor<OilUpliftDataModel>()) == 1)
    }

    @Test func preservesUnrelatedPendingChanges() throws {
        let (_, context, log) = try fixture()
        log.station = "KRK"
        #expect(throws: OilUpliftStore.SaveError.self) {
            try OilUpliftStore.saveNew(
                for: log,
                entries: [OilEntryDraft(system: .eng1, quantity: 1, unit: .usQuard)],
                notes: "", requireInspection: false, author: "mechanic", in: context
            )
        }
        #expect(log.station == "KRK")
        #expect(log.oilUplift == nil)
        #expect(context.hasChanges)
    }
}
