//·//  OIlSheetView.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 06/09/2026.
//


//
//++++++++++++++++++++++++++++++
// KROK 5
//++++++++++++++++++++++++++++++

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
    
 //   enum OilSystem: String, Codable, CaseIterable, Identifiable {
//        case eng1 = "ENG1"
//        case eng2 = "ENG2"
//        case apu = "APU"
//
//        var id: String { rawValue }
//    }
        
    //--DM
    @State private var selectedSystem: OilSystem?
    @State private var quantityText = ""
    @State private var selectedUnit: OilUnit = .usQuard
    @State private var draftEntries: [OilEntryDraft] = []
    @State private var notes = ""
    @State private var requireInspection = false
    
    //--oil
    
    private var enteredQuantity: Double?{
        let text = quantityText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: ",", with: ".")
        
        guard let quantity = Double(text),
            quantity.isFinite,
            quantity > 0 else {
            return nil
        }
        return quantity
    }
    
    private func addEntry(){
        guard let system = selectedSystem,
              let quantity = enteredQuantity else {
            return
        }
        
        if let index = draftEntries.firstIndex(where:
                                                { $0.system == system}
        ) {
            draftEntries[index].quantity = quantity
            draftEntries[index].unit = selectedUnit
        } else {
            draftEntries.append(
                        OilEntryDraft(
                            system: system,
                            quantity: quantity,
                            unit: selectedUnit
                        )
                    )
        }
        selectedSystem = nil
        quantityText = ""
    }
    
    
    var body: some View {
        
        ZStack {
            
            Color.theme.surfaceSecondary
            
            VStack{
                
                Divider()
                
                oilHeader()
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                
                Divider()
                
                //-- end of header
                
                Text("UPLIFTS")
                
                LazyVGrid(columns: syetemColumns, alignment: .center, spacing: 12){
                    
                    ForEach(OilSystem.allCases) {
                        system in
                        
                        Button{
                            
                            selectedSystem = system
                        } label: {
                            Text(system.rawValue)
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
                
                if let selectedSystem {
                    VStack(alignment: .leading, spacing: 12){
                        Text("Amount of \(selectedSystem.rawValue)")
                        
                        TextField("Put amount", text: $quantityText)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                        
                        Picker("unit", selection: $selectedUnit){
                            ForEach(OilUnit.allCases) { unit in
                                Text(unit.title)
                                    .tag(unit)
                            }
                            
                            Button("SAVE"){
                                addEntry()
                            }
                        }
                        .pickerStyle(.segmented)
                        
                    }
                    
                }
                
            }
            .onAppear{
                print("[VIEW] OilSheet Appear")
            }
        }
        .ignoresSafeArea()
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
