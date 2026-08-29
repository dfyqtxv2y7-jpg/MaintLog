//
//  HomeTabView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView{
            Tab("HOMe", systemImage: "house"){
                NavigationStack(){
                    HomeView()
                }
            }
        }
        .tint(Color.theme.actionPressed)
    }
}

#Preview {
    HomeTabView()
}
