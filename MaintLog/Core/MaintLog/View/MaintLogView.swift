//
//  MainLogView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogView: View {

    @Binding var path: NavigationPath

    @Environment(\.modelContext)
    private var modelContext

    @StateObject private var viewModel = MaintLogVM()
    
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
    
    //--SHEET
    @State private var showOilSheet = false
    
    //--UI
    @Bindable var log: MaintLogDataModel
    var body: some View {
        ZStack {
            Color.theme.surfacePrimary
                .ignoresSafeArea()
            ScrollView {
                
                logHeader()
                
                centerContainer()
                

                Button {
                   let savedRecord = viewModel.saveMaintLogRecord(
                        log,
                        in: modelContext
                    )
                    if savedRecord {
                        path = NavigationPath()
                    }
                } label: {
                    saveMaintLogButton()
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(log.mainLogNumber)")
                        .font(Font.largeTitle.bold())
                        .fontWeight(.semibold)
                    }
                }
            }
            .alert(
                "Could not save MaintLog",
                isPresented: Binding(
                    get: { viewModel.saveError != nil },
                    set: { isPresented in
                        if !isPresented {
                            viewModel.saveError = nil
                        }
                    }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.saveError ?? "Unknown error")
            }
    }
}
    
    
    #Preview {
        NavigationStack {
            MaintLogView(
                path: .constant(NavigationPath()),
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
        
        private func centerContainer() -> some View {
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.theme.borderDefault)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 500, maxHeight: 700)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .foregroundStyle(Color.theme.surfaceSecondary)
                .overlay(alignment: .topLeading){
                    VStack(alignment: .leading){
                        Text("Maintenance Action")
                            .foregroundStyle(Color.theme.textPrimary)
                            .font(Font.callout)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 40)
                            .padding(.top, 25)
                        
                        Divider()
                            .padding(.horizontal, 40)
                        
                        Button{
                            showOilSheet = true
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.theme.borderDefault)
                                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: 100)
                                .foregroundStyle(Color.theme.surfaceSecondary)
                                .overlay{
                                    HStack(spacing: 0) {
                                        Image(systemName: "drop.degreesign.fill")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundStyle(Color.theme.textPrimary)
                                            .frame(width:64)

                                        Divider()
                                            .padding(.vertical, 10)
                                        
                                        
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text("OIL UPLIFT")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color.theme.textPrimary)

                                            Text("TAP TO ADD OR SWIPE")
                                                .font(.caption)
                                                .fontWeight(.semibold)
                                                .foregroundStyle(Color.theme.textSecondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 16)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                }
            }
                    .sheet(isPresented: $showOilSheet) {
                        OIlSheetView()
                    }
        }
    }
        
        private func saveMaintLogButton() -> some View {
            RoundedRectangle(cornerRadius: 10)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 75, maxHeight: 75)
                .padding(.horizontal, 20)
                .foregroundStyle(Color.theme.actionPrimary)
                .overlay{
                  //  Spacer()
                    Text("Save MaintLog")
                        .foregroundStyle(Color.theme.textInverse)
                  //  Spacer()
                }
        }
}
