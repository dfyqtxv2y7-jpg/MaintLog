import Foundation
import SwiftData

// Podglądy używają własnej bazy w pamięci i dokumentu rzeczywiście dodanego do kontekstu.
@MainActor
enum MaintLogPreviewData {
    static func make() throws -> (container: ModelContainer, log: MaintLogDataModel) {
        let container = try ModelContainer(
            for: MaintLogDataModel.self, CustomerDataModel.self,
            OilUpliftDataModel.self, OilUpliftEntriesDataModel.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let context = container.mainContext
        try CustomerSeedDB.CustomerDB(into: context)
        let customer = try context.fetch(FetchDescriptor<CustomerDataModel>()).first
        let log = MaintLogDataModel(
            id: UUID(), mainLogNumber: "PREVIEW-001",
            departurePreviousAirport: "KRK", arrivalPreviousAirport: "WAW",
            flightNumberPreviousFlight: "LO3910", aircraftRegistration: "SP-LRA",
            aircraftType: "B787-8", aircraftSubType: "B787-8",
            referenceNo: "REF-001", station: "WAW", status: "OPEN", customer: customer
        )
        context.insert(log)
        try context.save()
        return (container, log)
    }
}
