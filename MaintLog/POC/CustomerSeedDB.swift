//
//  CustomerSeedDB.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 30/08/2026.
//

import Foundation
import SwiftData

enum CustomerSeedDB {
    static func CustomerDB(
        into context: ModelContext
    ) throws {
        var descriptor = FetchDescriptor<CustomerDataModel>()
        descriptor.fetchLimit = 1
        
        guard try context.fetch(descriptor).isEmpty else {
            return
        }
        
        let customers = [
            CustomerDataModel(name: "LOT Polish Airlines", iataCode: "LO", icaoCode: "LOT"),
            CustomerDataModel(name: "Enter Air", iataCode: "E4", icaoCode: "ENT"),
            CustomerDataModel(name: "Ryanair", iataCode: "FR", icaoCode: "RYR"),
            CustomerDataModel(name: "Wizz Air", iataCode: "W6", icaoCode: "WZZ"),
            CustomerDataModel(name: "Lufthansa", iataCode: "LH", icaoCode: "DLH"),
            CustomerDataModel(name: "Austrian Airlines", iataCode: "OS", icaoCode: "AUA"),
            CustomerDataModel(name: "SWISS", iataCode: "LX", icaoCode: "SWR"),
            CustomerDataModel(name: "KLM Royal Dutch Airlines", iataCode: "KL", icaoCode: "KLM"),
            CustomerDataModel(name: "Air France", iataCode: "AF", icaoCode: "AFR"),
            CustomerDataModel(name: "British Airways", iataCode: "BA", icaoCode: "BAW"),
            CustomerDataModel(name: "Finnair", iataCode: "AY", icaoCode: "FIN"),
            CustomerDataModel(name: "SAS Scandinavian Airlines", iataCode: "SK", icaoCode: "SAS"),
            CustomerDataModel(name: "Turkish Airlines", iataCode: "TK", icaoCode: "THY"),
            CustomerDataModel(name: "Emirates", iataCode: "EK", icaoCode: "UAE"),
            CustomerDataModel(name: "Qatar Airways", iataCode: "QR", icaoCode: "QTR"),
            CustomerDataModel(name: "TAP Air Portugal", iataCode: "TP", icaoCode: "TAP"),
            CustomerDataModel(name: "Iberia", iataCode: "IB", icaoCode: "IBE"),
            CustomerDataModel(name: "Vueling", iataCode: "VY", icaoCode: "VLG"),
            CustomerDataModel(name: "easyJet", iataCode: "U2", icaoCode: "EZY"),
            CustomerDataModel(name: "Norwegian Air Shuttle", iataCode: "DY", icaoCode: "NOZ"),
            CustomerDataModel(name: "Aegean Airlines", iataCode: "A3", icaoCode: "AEE"),
            CustomerDataModel(name: "airBaltic", iataCode: "BT", icaoCode: "BTI"),
            CustomerDataModel(name: "Eurowings", iataCode: "EW", icaoCode: "EWG"),
            CustomerDataModel(name: "Pegasus Airlines", iataCode: "PC", icaoCode: "PGT"),
            CustomerDataModel(name: "SunExpress", iataCode: "XQ", icaoCode: "SXS"),
            CustomerDataModel(name: "Air Serbia", iataCode: "JU", icaoCode: "ASL"),
            CustomerDataModel(name: "Croatia Airlines", iataCode: "OU", icaoCode: "CTN"),
            CustomerDataModel(name: "Bulgaria Air", iataCode: "FB", icaoCode: "LZB"),
            CustomerDataModel(name: "Smartwings", iataCode: "QS", icaoCode: "TVS"),
            CustomerDataModel(name: "ITA Airways", iataCode: "AZ", icaoCode: "ITY")
        ]
        for customer in customers{
            context.insert(customer)
        }
        
        try context.save()
    }
}
