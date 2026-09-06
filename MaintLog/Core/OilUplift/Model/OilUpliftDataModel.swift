//
//  OilUpliftDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//

import Foundation
import SwiftData
import Combine

@Model final class OilUpliftData {
    
    @Attribute(.unique)
    var id: UUID
    
    var e1QTY: Double
    var e2QTY: Double
    var e3QTY: Double
    var e4QTY: Double
    var apuQTY: Double
    var unit: String
    var notes: String
    var requireInspection: Bool
    var performInspectioBy: String
    var performInspectioAt: Date
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date
    var updatedBy: String
    
    
    //-- RELATION    
    var maintLog: [MaintLogDataModel] = []
    
    init(id: UUID,
         e1QTY: Double,
         e2QTY: Double,
         e3QTY: Double,
         e4QTY: Double,
         APUQTY: Double,
         unit: String,
         notes: String,
         requireInspection: Bool,
         performInspectioBy: String,
         performInspectioAt: Date,
         createdBy: String,
         createdAt: Date,
         updatedAt: Date,
         updatedBy: String)
    {
        self.id = id
        self.e1QTY = e1QTY
        self.e2QTY = e2QTY
        self.e3QTY = e3QTY
        self.e4QTY = e4QTY
        self.apuQTY = APUQTY
        self.unit = unit
        self.notes = notes
        self.requireInspection = requireInspection
        self.performInspectioBy = performInspectioBy
        self.performInspectioAt = performInspectioAt
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.updatedBy = updatedBy
    }
}
