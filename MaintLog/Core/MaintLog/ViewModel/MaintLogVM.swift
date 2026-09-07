//
//  MaintLogVM.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 07/09/2026.
//

import Foundation
import SwiftData
import Combine

@MainActor final class MaintLogVM: ObservableObject {

    @Published var saveError: String?

    @discardableResult
    func saveMaintLogRecord(
        _ log: MaintLogDataModel,
        in modelContext: ModelContext,
        updatedBy: String? = nil
    ) -> Bool {
        log.updatedAt = Date()

        if let updatedBy {
            log.updatedBy = updatedBy
        }

        do {
            try modelContext.save()
            saveError = nil
            return true
        } catch {
            modelContext.rollback()
            saveError = error.localizedDescription
            return false
        }
    }
}
