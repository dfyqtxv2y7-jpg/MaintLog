//
//  OilSystemDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 21/09/2026.
//

import Foundation


enum OilSystem: String, Codable, CaseIterable, Identifiable {
    case eng1 = "ENG1"
    case eng2 = "ENG2"
    case eng3 = "ENG3"
    case eng4 = "ENG4"
    case apu = "APU"
    case hyd1 = "HYD1"
    case hyd2 = "HYD2"
    case hyd3 = "HYD3"

    var id: String { rawValue }
}
