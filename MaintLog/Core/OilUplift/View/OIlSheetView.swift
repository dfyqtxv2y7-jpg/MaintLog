//
//  OIlSheetView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//

import SwiftUI

struct OIlSheetView: View {
    
    //--LOGIC
    let log: MaintLogDataModel
    
    
    var body: some View {
        
        VStack{
            Text("hello oil  sheet")
        }
        .onAppear{
            print("[VIEW] OilSheet Appear")
        }
    }
}

#Preview {
    OIlSheetView(log: MaintLogDataModel(
        id: UUID(),
        mainLogNumber: "MWL-2026-084",
        departurePreviousAirport: "KRK",
        arrivalPreviousAirport: "WAW",
        flightNumberPreviousFlight: "LO3910",
        aircraftRegistration: "SP-LRA",
        aircraftType: "B787-8",
        aircraftSubType: "B787-8",
        referenceNo: "REF-001",
        station: "WAW",
        status: "OPEN"
    ))
}
