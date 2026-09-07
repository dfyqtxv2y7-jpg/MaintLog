//
//  HomeView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {

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

            MaintLogListView(records: filteredRecords)
            .scrollContentBackground(.hidden)

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
    NavigationStack {
        HomeView()
    }
    .modelContainer(
        for: [
            MaintLogDataModel.self,
            CustomerDataModel.self,
            OilUpliftDataModel.self
        ],
        inMemory: true
    )
}
