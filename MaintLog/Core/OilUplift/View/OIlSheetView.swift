//·//  OIlSheetView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//

import SwiftUI

struct OIlSheetView: View {
    
    //--LOGIC
    let log: MaintLogDataModel
    
    //--GRID
    let systemUplift = [
        "ENG1",
        "ENG2",
        "ENG3",
        "ENG4",
        "APU",
        "HYD1",
        "HYD2",
        "HYD3"
    ]
    
    let syetemColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        
        VStack{
            
            Divider()
            
            oilHeader()
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
            
            Divider()
            
            //-- end of header
            
            Text("UPLIFTS")
            
            LazyVGrid(columns: syetemColumns, alignment: .center, spacing: 12){
                
                ForEach(systemUplift, id: \.self) {
                    systemUplift in
                    
                    Button{
                        
                    } label: {
                        Text(systemUplift)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.theme.textPrimary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.8)
                            .frame(width: 100)
                            .frame(height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.theme.borderDefault)
                                    .fill(
                                        Color.theme.fieldBackground
                                    )
                            )
                        
                        
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 25)
        
        }
        .onAppear{
            print("[VIEW] OilSheet Appear")
        }
    }
}

#Preview {
    OIlSheetView(log: MaintLogDataModel(
        id: UUID(),
        mainLogNumber: "MWL-2026-084",
        departurePreviousAirport: "KRK",
        arrivalPreviousAirport: "WAW",
        flightNumberPreviousFlight: "LO3910",
        aircraftRegistration: "SP-LRA",
        aircraftType: "B787-8",
        aircraftSubType: "B787-8",
        referenceNo: "REF-001",
        station: "WAW",
        status: "OPEN"
    ))
}

extension OIlSheetView{
    
    private func oilHeader() -> some View{
        HStack{
            
            Text(log.aircraftRegistration)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.theme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Text("·")
            Text(log.aircraftType)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.theme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Spacer()
            
            Text(log.mainLogNumber)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.theme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}
