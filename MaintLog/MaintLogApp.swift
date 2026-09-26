//
//  MaintLogApp.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 23/08/2026.
//

import SwiftUI
import SwiftData

@main
struct MaintLogApp: App {
    var body: some Scene {
        WindowGroup {
            HomeTabView()
                // Cała nawigacja i arkusze dziedziczą jeden kontener z korzenia widoków.
                .modelContainer(
                    for: [
                        MaintLogDataModel.self,
                        CustomerDataModel.self,
                        OilUpliftDataModel.self,
                        OilUpliftEntriesDataModel.self
                    ]
                )
        }
    }
}
