//
//  MainLogView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogView: View {
    
    @Bindable var log: MaintLogDataModel
    var body: some View {
        Text(log.mainLogNumber)
    }
}


#Preview {
    NavigationStack {
        MaintLogView(
            log: MaintLogDataModel(
                id: UUID(),
                mainLogNumber: "A12B3C-WAW",
                departurePreviousAirport: "KRK",
                arrivalPreviousAirport: "WAW",
                flightNumberPreviousFlight: "LO3910",
                aircraftRegistration: "SP-LWA",
                aircraftType: "B737",
                aircraftSubType: "B737-800",
                referenceNo: "REF-001",
                station: "WAW",
                status: "open"
            )
        )
    }
    .modelContainer(
        for: MaintLogDataModel.self,
        inMemory: true
    )
}
