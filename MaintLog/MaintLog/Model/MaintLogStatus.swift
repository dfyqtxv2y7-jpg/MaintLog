//
//  MaintLogStatus.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 30/08/2026.
//

import Foundation
import SwiftUI

enum MaintLogStatus: String, CaseIterable {
    case open = "OPEN"
    case inProgress = "IN PROGRESS"
    case pending = "PENDING"
    case onHold = "ON HOLD"
    case closed = "CLOSED"
    
    
    var title: String {
        switch self {
        case .open:
            return "Open"
        case .inProgress:
            return "In Progress"
        case .pending:
            return "Pending"
        case .onHold:
            return "On Hold"
        case .closed:
            return "Closed"
        }
    }
    
    var statusBadge: Color {
        switch self {
        case .open:
            return .green
        case .inProgress:
            return .yellow
        case .pending:
            return .orange
        case .onHold:
            return .purple
        case .closed:
            return .red
        }
    }
}
