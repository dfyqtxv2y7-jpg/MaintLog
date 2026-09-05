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
    
    //--GLOBAL
    @Published var saveError: String?
    
    //--ID
    private var currentMaintLogID = 1000
    
    
    //--FUNC
    private func createMaintLogID(arrivalPreviousAirport: String) -> (id: UUID, number: String)
    {
       let id = UUID()
        
        currentMaintLogID += 1
        
       // let idPart = id.uuidString.prefix(6).uppercased()
        let stationPart = arrivalPreviousAirport.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        return(
            id: id,
            number: "\(currentMaintLogID)-\(stationPart)"
        )
    }
    
    func saveMaintLogForm(
        in modelContext: ModelContext,
        departurePreviousAirport: String,
        departurePreviousTime: Date? = nil,
        arrivalPreviousAirport: String,
        arrivalPreviousTime: Date? = nil,
        flightNumberPreviousFlight: String,
        departureScheduleAirport: String? = nil,
        departureScheduleTime: Date? = nil,
        arrivalScheduleAirport: String? = nil,
        flightNumberScheduleFlight: String? = nil,
        aircraftRegistration: String,
        aircraftType: String,
        aircraftSubType: String,
        referenceNo: String,
        station: String,
        status: String,
        hasDefect: Bool? = nil,
        hasPlannedWork: Bool? = nil,
        hasOilUplift: Bool? = nil,
        hasReport: Bool? = nil,
        customer: String? = nil,
        createdBy: String? = nil,
        updatedBy: String? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil
    ) -> MaintLogDataModel? {
        
        let identity = createMaintLogID(arrivalPreviousAirport: arrivalPreviousAirport)
        let now = Date()
        
        let log = MaintLogDataModel(
            id: identity.id,
            mainLogNumber: identity.number,
            departurePreviousAirport: departurePreviousAirport,
            departurePreviousTime: departurePreviousTime,
            arrivalPreviousAirport: arrivalPreviousAirport,
            arrivalPreviousTime: arrivalPreviousTime,
            flightNumberPreviousFlight: flightNumberPreviousFlight,
            departureScheduleAirport: departureScheduleAirport,
            departureScheduleTime: departureScheduleTime,
            arrivalScheduleAirport: arrivalScheduleAirport,
            flightNumberScheduleFlight: flightNumberScheduleFlight,
            aircraftRegistration: aircraftRegistration,
            aircraftType: aircraftType,
            aircraftSubType: aircraftSubType,
            referenceNo: referenceNo,
            station: station,
            status: status,
            hasDefect: false,
            hasPlannedWork: false,
            hasOilUplift: false,
            hasReport: false,
            customer: customer,
            createdAt: now,
            updatedAt: now
            )
        modelContext.insert(log)
        
        do{
            try modelContext.save()
            saveError = nil
            return log
        } catch {
            modelContext.rollback()
            saveError = error.localizedDescription
            return nil
            
        }
    }
}
