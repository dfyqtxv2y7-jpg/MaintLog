//
//  HomeView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    //-- SORT + FILTER VIEW
    
    private enum HomeFilterViewState:String, CaseIterable, Identifiable {
        case all = "ALL"
        case open = "OPEN"
        case closed = "CLOSED"
        
        var id: Self { self }
    }
    
    @Query (sort: \MaintLogDataModel.createdAt, order: .reverse)
    private var records: [MaintLogDataModel]
    
    @State private var selectedFilterView: HomeFilterViewState = .all
    
    private var filteredRecords: [MaintLogDataModel] {
        switch selectedFilterView {
        case .all:
            return records
        case .open:
            return records.filter{
                $0.status == MaintLogStatus.open.rawValue
            }
        case .closed:
            return records.filter{
                $0.status == MaintLogStatus.closed.rawValue
            }
        }
    }
    
    

    var body: some View {
        VStack {
            List {
                
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Hello <User> 👋")
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
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
  //  HomeView()
}
