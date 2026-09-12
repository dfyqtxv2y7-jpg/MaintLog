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
                MaintLogRow(record: record)
            }
        }
    }
}

private struct MaintLogRow: View {
    let record: MaintLogDataModel

    var body: some View {
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

#Preview("MaintLog row", traits: .sizeThatFitsLayout) {
    MaintLogRow(
        record: MaintLogDataModel(
            id: UUID(),
            mainLogNumber: "ML-2026-001",
            departurePreviousAirport: "WAW",
            arrivalPreviousAirport: "FRA",
            flightNumberPreviousFlight: "LO381",
            aircraftRegistration: "SP-LWA",
            aircraftType: "Boeing",
            aircraftSubType: "B737-800",
            referenceNo: "REF-001",
            station: "WAW",
            status: MaintLogStatus.open.rawValue
        )
    )
    .padding()
    .frame(width: 350, alignment: .leading)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .overlay {
        RoundedRectangle(cornerRadius: 12)
            .stroke(.gray.opacity(0.4), lineWidth: 1)
    }
    .padding()
    Spacer()
}
