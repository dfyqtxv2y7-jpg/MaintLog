//
//  MaintLogFormVM.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 30/08/2026.
//

import Foundation
import SwiftData
import Combine

@MainActor final class MaintLogFormVM: ObservableObject {
    
    @Published var saveError: String?
    
    private func createMaintLogID(arrivalPreviousAirport: String) -> (id: UUID, number: String){
        
        let id = UUID()
        
        let idPart = id.uuidString.prefix(6).uppercased()
        let stationPart = arrivalPreviousAirport.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        return(
            id: id,
            number: "\(idPart)-\(stationPart)"
        )
    }
    
}
