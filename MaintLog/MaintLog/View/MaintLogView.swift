//
//  MainLogView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogView: View {
    
    @State private var departurePreviousAirport = ""
    @State private var departurePreviousTime: Date? = nil
    @State private var arrivalPreviousAirport = ""
    @State private var arrivalPreviousTime = Date()
    @State private var flightNumberPreviousFlight = ""
    @State private var departureScheduleAirport = ""
    @State private var departureScheduleTime = Date()
    @State private var arrivalScheduleAirport: String? = nil
    @State private var flightNumberScheduleFlight = ""
    @State private var aircraftRegistration = ""
    @State private var aircraftType = ""
    @State private var aircraftSubType = ""
    @State private var referenceNo = ""
    @State private var station = ""
    
    
    @Bindable var log: MaintLogDataModel
    var body: some View {
        ZStack {
            Color.theme.surfacePrimary
                .ignoresSafeArea()
            ScrollView {
                
                logHeader()
                
            }
                    .toolbar{
                        ToolbarItem(placement: .principal) {
                            Text("\(log.mainLogNumber)")
                                .font(Font.largeTitle.bold())
                                .fontWeight(.semibold)
                        }
                    }
            }
        }
    }
    
    
    #Preview {
        NavigationStack {
            MaintLogView(
                log: MaintLogDataModel(
                    id: UUID(),
                    mainLogNumber: "WAW-10001",
                    departurePreviousAirport: "KRK",
                    arrivalPreviousAirport: "WAW",
                    flightNumberPreviousFlight: "LO3910",
                    aircraftRegistration: "SP-LWA",
                    aircraftType: "B737",
                    aircraftSubType: "B737-800",
                    referenceNo: "REF-001",
                    station: "WAW",
                    status: "OPEN",
                    customer: nil
                )
            )
        }
        .modelContainer(
            for:
                [MaintLogDataModel.self,
                 CustomerDataModel.self],
            inMemory: true
        )
    }
    
    extension MaintLogView{
        
        private func logHeader() -> some View {
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.theme.borderDefault)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 325)
                .padding(.horizontal, 20)
                .foregroundStyle(Color.theme.surfaceSecondary)
                .overlay{
                    HStack{
                        Image(systemName: "airplane")
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        VStack{
                            Text("\(log.aircraftRegistration)  ・  \(log.aircraftType)")
                                .font(Font.title3)
                                .fontWeight(.semibold)
                            Text("\(log.customer?.name)" ?? "N/A")
                            
                        }
                        
                        Divider()
                            .padding(.vertical, 10)
                        
                        Rectangle()
                            .stroke(MaintLogStatus(rawValue: log.status)?.statusBadge ?? .gray)
                            .frame(width: 75, height: 30)
                            .overlay{
                                Text("\(log.status)")
                                    .foregroundStyle(MaintLogStatus(rawValue: log.status)?.statusBadge ?? .gray)
                                    .fontWeight(.semibold)
                            
                }
            }
        }
    }
}
