//
//  OilUpliftEntriesDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 21/09/2026.
//

import Foundation
import SwiftData


@Model final class OilUpliftEntriesDataModel{
    
    var id: UUID
    var system: String
    var quantity: Double
    var unit: String
    
    
    var oiluplift: OilUpliftDataModel?
    
    init(
        id: UUID,
        system: String,
        quantity: Double,
        unit: String,
        oiluplift: OilUpliftDataModel? = nil
    ) {
        self.id = id
        self.system = system
        self.quantity = quantity
        self.unit = unit
        self.oiluplift = oiluplift
    }
}
