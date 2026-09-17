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
            Color.theme.surfaceSecondary
                .ignoresSafeArea()
            ScrollView {
                Text(log.mainLogNumber)
                    .font(.largeTitle.weight(.semibold))
                    .foregroundStyle(Color.theme.textPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .padding(.bottom, 8)

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
                    Text("Maint / Work Log")
                        .font(.headline)
                }
            }
        }
        .onAppear{
            print("[VIEW] MaintLogView Appear")
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
                    mainLogNumber: "MWL-2026-084",
                    departurePreviousAirport: "KRK",
                    arrivalPreviousAirport: "WAW",
                    flightNumberPreviousFlight: "LO3910",
                    aircraftRegistration: "SP-LRA",
                    aircraftType: "B787-8",
                    aircraftSubType: "B787-8",
                    referenceNo: "REF-001",
                    station: "WAW",
                    status: "OPEN",
                    customer: CustomerDataModel(
                        name: "LOT Polish Airlines",
                        iataCode: "LO",
                        icaoCode: "LOT"
                    )
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
            let statusColor = MaintLogStatus(rawValue: log.status)?.statusBadge ?? .gray

            return HStack(spacing: 10) {
                Image(systemName: "airplane")
                    .font(.system(size: 34, weight: .ultraLight))
                    .foregroundStyle(Color.theme.textPrimary)
                    .frame(width: 42)

                Divider()
                    .frame(height: 44)

                VStack(alignment: .leading, spacing: 5) {
                    Text("\(log.aircraftRegistration)  ·  \(log.aircraftType)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.theme.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(log.customer?.name ?? "N/A")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.theme.textSecondary)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text(log.status)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(statusColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .frame(width: 90, height: 30)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(statusColor)
                    }
            }
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity)
            .frame(height: 88)
            .background(Color.theme.surfacePrimary, in: RoundedRectangle(cornerRadius: 14))
            .overlay {
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.borderDefault)
            }
            .padding(.horizontal, 20)
        }
        
        private func centerContainer() -> some View {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.theme.surfacePrimary)
                .stroke(Color.theme.borderDefault)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 500, maxHeight: 700)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
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
                                .foregroundStyle(Color.theme.surfacePrimary)
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
