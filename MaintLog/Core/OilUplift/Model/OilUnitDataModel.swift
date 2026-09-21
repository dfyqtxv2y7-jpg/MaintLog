//
//  OilUnitDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 21/09/2026.
//

import Foundation


enum OilUnit: String, Codable, CaseIterable, Identifiable{
    case usQuard = "Q"
    case litres = "L"
    
    var id: String {rawValue}
    
    var title: String{
        switch self{
        case .usQuard:
            return "Q"
        case .litres:
            return "L"
        }
    }
}
