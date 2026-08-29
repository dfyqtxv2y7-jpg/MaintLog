//
//  CustomerDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import Foundation
import SwiftData

final class CustomerDataModel{
    
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var shortName: String
    var iataCode: String
    var icaoCode: String
    var isActive: Bool
    
    init(id: UUID,
         name: String,
         shortName: String,
         iataCode: String,
         icaoCode: String,
         isActive: Bool)
    {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.iataCode = iataCode
        self.icaoCode = icaoCode
        self.isActive = isActive
    }
}
