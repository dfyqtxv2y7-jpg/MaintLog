//
//  OilEntryDraft.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 21/09/2026.
//

import Foundation
import SwiftData

struct OilEntryDraft: Identifiable{
    var id: UUID
    var system: OilSystem
    var quantity: Double
    var unit: OilUnit
}
