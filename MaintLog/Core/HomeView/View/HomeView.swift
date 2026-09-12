//
//  HomeView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    
    //--FILTER
    private enum HomeFilterViewState: String, CaseIterable, Identifiable {
        case all = "ALL"
        case open = "OPEN"
        case closed = "CLOSED"

        var id: Self { self }
    }

    @Query(sort: \MaintLogDataModel.createdAt, order: .reverse)
    private var records: [MaintLogDataModel]

    @State private var selectedFilterView: HomeFilterViewState = .all

    private var filteredRecords: [MaintLogDataModel] {
        switch selectedFilterView {
        case .all:
            return records
        case .open:
            return records.filter {
                $0.status == MaintLogStatus.open.rawValue
            }
        case .closed:
            return records.filter {
                $0.status == MaintLogStatus.closed.rawValue
            }
        }
    }

    var body: some View {
        
        //--UPPER TAB
        VStack(spacing: 0) {
            Picker("MaintLog status", selection: $selectedFilterView) {
                ForEach(HomeFilterViewState.allCases) { filter in
                    Text(filter.rawValue)
                        .tag(filter)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.top)

            //--ROW
            MaintLogListView(records: filteredRecords)
            .scrollContentBackground(.hidden)

            //--BUTTON
            NavigationLink(value: HomeRoute.createMaintLog) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 75)
                    .padding()
                    .foregroundStyle(Color.theme.actionPrimary)
                    .overlay{
                        Text("Create new MainLog")
                            .foregroundStyle(Color.theme.textInverse)
                    }
            }
        }
        .background(Color.theme.surfacePrimary)
        .navigationTitle("Hello <User> 👋")
    }
}


#Preview {
    let container = try! ModelContainer(
        for:
            MaintLogDataModel.self,
            CustomerDataModel.self,
            OilUpliftDataModel.self,
        configurations: ModelConfiguration(
            isStoredInMemoryOnly: true
        )
    )

    let context = container.mainContext

    context.insert(
        MaintLogDataModel(
            id: UUID(),
            mainLogNumber: "ML-2026-001",
            departurePreviousAirport: "WAW",
            arrivalPreviousAirport: "FRA",
            flightNumberPreviousFlight: "LO381",
            aircraftRegistration: "SP-LWA",
            aircraftType: "Boeing",
            aircraftSubType: "B737-800",
            referenceNo: "REF-001",
            station: "WAW",
            status: MaintLogStatus.open.rawValue,
            createdAt: .now
        )
    )

    context.insert(
        MaintLogDataModel(
            id: UUID(),
            mainLogNumber: "ML-2026-002",
            departurePreviousAirport: "KRK",
            arrivalPreviousAirport: "WAW",
            flightNumberPreviousFlight: "LO3904",
            aircraftRegistration: "SP-LIA",
            aircraftType: "Embraer",
            aircraftSubType: "E175",
            referenceNo: "REF-002",
            station: "WAW",
            status: MaintLogStatus.closed.rawValue,
            createdAt: .now.addingTimeInterval(-3600)
        )
    )

    return NavigationStack {
        HomeView()
    }
    .modelContainer(container)
}
