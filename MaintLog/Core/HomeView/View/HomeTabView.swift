//
//  HomeTabView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI

enum HomeRoute: Hashable {
    case createMaintLog
    case maintLog(MaintLogDataModel)
}

struct HomeTabView: View {
    @State private var homePath = NavigationPath()

    var body: some View {
        TabView{
            Tab("HOMe", systemImage: "house"){
                NavigationStack(path: $homePath) {
                    HomeView()
                        .navigationDestination(for: HomeRoute.self) { route in
                            switch route {
                            case .createMaintLog:
                                MaintLogForm(path: $homePath)
                            case .maintLog(let log):
                                MaintLogView(
                                    path: $homePath,
                                    log: log
                                )
                            }
                        }
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

