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
        NavigationLink{
            MaintLogForm()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 75)
                .padding()
                .foregroundStyle(Color.red)
                .overlay{
                    Text("Create new MainLog")
                        .foregroundStyle(Color.white)
                }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
  //  HomeView()
}
