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
        }
        .modelContainer(
            for: [
                MaintLogDataModel.self,
                CustomerDataModel.self,
                OilUpliftDataModel.self
            ]
        )
    }
}
