//
//  OilUpliftDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//

import Foundation
import SwiftData

@Model final class OilUpliftDataModel {
    
    @Attribute(.unique)
    var id: UUID
    
    //-- RELATION
    // Istniejąca baza przechowuje relację jako tablicę. Zmiana na pojedynczy obiekt
    // wymaga osobnej migracji; zachowujemy format, aby nie blokować odczytu danych.
    // Nowy zestaw jest przypisywany tylko do jednego dokumentu przez OilUpliftStore.
    var maintLog: [MaintLogDataModel] = []
    
    @Relationship(
        deleteRule: .cascade,
        inverse:\OilUpliftEntriesDataModel.oiluplift
    )
    var entries: [OilUpliftEntriesDataModel] = []
    
    
    var e1QTY: Double
    var e2QTY: Double
    var e3QTY: Double
    var e4QTY: Double
    var apuQTY: Double
    var unit: String
    var notes: String
    var requireInspection: Bool
    var performInspectioBy: String?
    var performInspectioAt: Date?
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date
    var updatedBy: String
    
    
    init(id: UUID = UUID(),
         e1QTY: Double = 0,
         e2QTY: Double = 0,
         e3QTY: Double = 0,
         e4QTY: Double = 0,
         APUQTY: Double = 0,
         unit: String = "",
         notes: String = "",
         requireInspection: Bool = false,
         performInspectioBy: String? = nil,
         performInspectioAt: Date? = nil,
         createdBy: String,
         createdAt: Date = Date(),
         updatedAt: Date = Date(),
         updatedBy: String? = nil)
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
        self.updatedBy = updatedBy ?? createdBy
    }
}
