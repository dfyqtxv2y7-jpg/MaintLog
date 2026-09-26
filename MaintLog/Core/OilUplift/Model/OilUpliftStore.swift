import Foundation
import SwiftData

// Zapis poza widokiem pozwala przetestować relacje i walidację bez interfejsu.
@MainActor
enum OilUpliftStore {
    enum SaveError: LocalizedError {
        case existingUplift, missingAuthor, invalidEntries, pendingChanges, detachedLog

        var errorDescription: String? {
            switch self {
            case .existingUplift:
                return "Ten MaintLog ma już zapisane uzupełnienia. Edycja nie jest jeszcze dostępna."
            case .missingAuthor:
                return "Podaj autora zapisu."
            case .invalidEntries:
                return "Dodaj dodatnie ilości, po jednej pozycji dla każdego systemu."
            case .pendingChanges:
                return "Istnieją inne niezapisane zmiany. Zakończ ich zapis przed zapisaniem uzupełnień."
            case .detachedLog:
                return "Dokument nie jest połączony z bazą tego formularza. Otwórz go ponownie z listy MaintLog."
            }
        }
    }

    static func saveNew(
        for log: MaintLogDataModel,
        entries: [OilEntryDraft],
        notes: String,
        requireInspection: Bool,
        author: String,
        in context: ModelContext
    ) throws {
        guard log.modelContext === context else { throw SaveError.detachedLog }
        guard log.oilUplift == nil else { throw SaveError.existingUplift }
        let author = author.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !author.isEmpty else { throw SaveError.missingAuthor }
        guard !entries.isEmpty,
              entries.allSatisfy({ $0.quantity.isFinite && $0.quantity > 0 }),
              Set(entries.map(\.system)).count == entries.count,
              Set(entries.map(\.id)).count == entries.count else {
            throw SaveError.invalidEntries
        }

        guard !context.hasChanges else { throw SaveError.pendingChanges }

        let uplift = OilUpliftDataModel(
            notes: notes,
            requireInspection: requireInspection,
            createdBy: author
        )
        context.insert(uplift)
        for draft in entries {
            let entry = OilUpliftEntriesDataModel(
                id: draft.id,
                system: draft.system.rawValue,
                quantity: draft.quantity,
                unit: draft.unit.rawValue
            )
            context.insert(entry)
            uplift.entries.append(entry)
        }

        log.oilUplift = uplift
        log.hasOilUplift = true
        log.updatedAt = Date()
        log.updatedBy = author

        do {
            try context.save()
        } catch {
            context.rollback()
            throw error
        }
    }
}
