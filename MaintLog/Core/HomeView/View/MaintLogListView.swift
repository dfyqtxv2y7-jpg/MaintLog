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
            .listRowInsets(
                EdgeInsets(
                    top: 6,
                    leading: 6,
                    bottom: 6,
                    trailing: 6
                )
                )
        }
    }
}

private struct MaintLogRow: View {
    let record: MaintLogDataModel

    var body: some View {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(record.mainLogNumber)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.theme.textPrimary)
                    
                    
                    HStack {
                        Text(record.aircraftRegistration)
                        Text("•")
                        Text(record.aircraftType)
                    }
                    .font(.callout)
                    .foregroundStyle(Color.theme.textSecondary)
                    
                    
                    Text(record.customer?.name ?? "N/A")
                        .font(.caption)
                        .foregroundStyle(Color.theme.textSecondary)
                }
                Spacer()

                Text("\(record.status)")
                    .foregroundStyle(MaintLogStatus(rawValue: record.status)?.statusBadge ?? .gray)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .overlay{
                                Rectangle()
                        .stroke(MaintLogStatus(rawValue:record.status)?.statusBadge ?? .gray)
                        .frame(minWidth: 20, maxWidth: 80, minHeight: 20, maxHeight: 25)
                }
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.theme.borderDefault, lineWidth: 1)
                    .frame(minWidth: 100,
                           maxWidth: .infinity,
                           minHeight:100, maxHeight: 100
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
            aircraftType: "B737-800",
            aircraftSubType: "B737-800",
            referenceNo: "REF-001",
            station: "WAW",
            status: MaintLogStatus.open.rawValue,
            customer: CustomerDataModel(
                name: "AIRFRANCE",
                iataCode: "",
                icaoCode: ""
            )
        )
    )
    .padding()
    .frame(width: 350, alignment: .leading)
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 12))
//    .overlay {
//        RoundedRectangle(cornerRadius: 12)
//            .stroke(.gray.opacity(0.4), lineWidth: 1)
//    }
    .padding()
    Spacer()
}
