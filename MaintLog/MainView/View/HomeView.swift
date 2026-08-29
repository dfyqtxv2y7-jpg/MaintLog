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

    var body: some View {
        List {
        
        }
        .scrollContentBackground(.hidden)
        .background(Color.theme.surfaceSecondary)
        .navigationTitle("Hello <User> 👋")
        NavigationLink{
            MaintLogForm()
        } label: {
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
    //(Color.theme.actionPrimary)
}

#Preview {
    NavigationStack {
        HomeView()
    }
  //  HomeView()
}
