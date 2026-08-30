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
            Tab("Inventory", systemImage: "shippingbox.fill"){
                NavigationStack(){
                    InventoryView()
                }
            }
            Tab("Customer", systemImage: "person.spatialaudio.stereo.fill"){
                NavigationStack(){
                    CustomerView()
                }
            }
        }
        .tint(Color.theme.actionPressed)
    }
}

#Preview {
    HomeTabView()
}
