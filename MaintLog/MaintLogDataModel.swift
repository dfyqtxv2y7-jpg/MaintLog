//
//  MaintLogDataModel.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import Foundation
import SwiftData

@Model
final class MaintLogDataModel {
    @Attribute(.unique)
    var id: UUID
    
    @Attribute(.unique)
    var mainLogNumber: String
    
    
    //--FLIGHT
    var departurePreviousAirport: String
    var arrivalPreviousAirport: String?
    var flightNumberPreviousFlight: String
    var departureScheduleAirport: String?
    var arrivalScheduleAirport: String?
    var flightNumberScheduleFlight: String?
    
    //--AC
    var aircraftRegistration: String
    var aircraftType: String
    var aircraftSubType: String
    
    //--infoLog
    var referenceNo: String
    var station: String
    var status: String
    var hasDefect: Bool?
    var hasPlannedWork: Bool?
    var hasOilUplift: Bool?
    var hasReport: Bool?
    var customer: String?
    
    //--audit
    var createdBy: String?
    var updatedBy: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    init(id: UUID,
         mainLogNumber: String,
         departurePreviousAirport: String,
         arrivalPreviousAirport: String? = nil,
         flightNumberPreviousFlight: String,
         departureScheduleAirport: String? = nil,
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
         updatedAt: Date? = nil)
    {
        self.id = id
        self.mainLogNumber = mainLogNumber
        self.departurePreviousAirport = departurePreviousAirport
        self.arrivalPreviousAirport = arrivalPreviousAirport
        self.flightNumberPreviousFlight = flightNumberPreviousFlight
        self.departureScheduleAirport = departureScheduleAirport
        self.arrivalScheduleAirport = arrivalScheduleAirport
        self.flightNumberScheduleFlight = flightNumberScheduleFlight
        self.aircraftRegistration = aircraftRegistration
        self.aircraftType = aircraftType
        self.aircraftSubType = aircraftSubType
        self.referenceNo = referenceNo
        self.station = station
        self.status = status
        self.hasDefect = hasDefect
        self.hasPlannedWork = hasPlannedWork
        self.hasOilUplift = hasOilUplift
        self.hasReport = hasReport
        self.customer = customer
        self.createdBy = createdBy
        self.updatedBy = updatedBy
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}


