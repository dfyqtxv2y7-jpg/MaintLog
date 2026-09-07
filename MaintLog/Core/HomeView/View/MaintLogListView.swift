//
//  MaintLogListView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 07/09/2026.
//

import SwiftUI

struct MaintLogListView: View {
    let records: [MaintLogDataModel]

    var body: some View {
        List(records) { record in
            NavigationLink(value: HomeRoute.maintLog(record)) {
                VStack(alignment: .leading) {
                    Text(record.mainLogNumber)
                        .font(.headline)

                    Text(record.aircraftRegistration)

                    Text(record.status)
                        .foregroundStyle(
                            MaintLogStatus(rawValue: record.status)?
                                .statusBadge ?? .gray
                        )
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        MaintLogListView(records: [])
    }
}
