//
//  MaintLogForm.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogForm: View {
    
    @Query(sort: \CustomerDataModel.name)
    private var customer: [CustomerDataModel]
    
    //--DATA MODEL
    @State private var departurePreviousAirport = ""
    @State private var departurePreviousTime: Date? = nil
    @State private var arrivalPreviousAirport: String? = nil
    @State private var arrivalPreviousTime: Date? = nil
    @State private var flightNumberPreviousFlight = ""
    @State private var departureScheduleAirport: String? = nil
    @State private var departureScheduleTime: Date? = nil
    @State private var arrivalScheduleAirport: String? = nil
    @State private var flightNumberScheduleFlight: String? = nil
    @State private var aircraftRegistration = ""
    @State private var aircraftType = ""
    @State private var aircraftSubType = ""
    @State private var referenceNo = ""
    @State private var station = ""
    @State private var status = "open"
    
    //--CUSTOMER LOGIC
    
    
    var body: some View {
        ZStack{
            Color.theme.surfacePrimary
                .ignoresSafeArea()
            VStack{
                
            }
            .navigationTitle(Text("MaintLog"))
        }
    }
}

#Preview {
//    MaintLogForm(
//    )
    NavigationStack{
        MaintLogForm()
            .modelContainer(
                for: [
                    MaintLogDataModel.self,
                    CustomerDataModel.self
                ],
                inMemory: true
            )
    }
}
