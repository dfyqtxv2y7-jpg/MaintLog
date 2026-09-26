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
import SwiftData

struct OIlSheetView: View {
    
    //--LOGIC
    let log: MaintLogDataModel
    
    //--GRID
    let syetemColumns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12),
//        GridItem(.flexible(), spacing: 12)
    ]
    
    //-- ENV
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var saveError: String?
    @State private var author = ""
    
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
    
    private func saveEntries() {
        if !quantityText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            guard selectedSystem != nil, enteredQuantity != nil else {
                saveError = "Popraw ilość przed zapisaniem."
                return
            }

            addEntry()
        }

        guard !draftEntries.isEmpty else {
            saveError = "Dodaj przynajmniej jedną pozycję."
            return
        }

        do {
            try OilUpliftStore.saveNew(
                for: log,
                entries: draftEntries,
                notes: notes,
                requireInspection: requireInspection,
                author: author,
                in: modelContext
            )
            dismiss()
        } catch {
            saveError = error.localizedDescription
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color.theme.surfaceSecondary
                .ignoresSafeArea()

            ScrollView {
            VStack(spacing: 16){
                
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
                        }
                        .pickerStyle(.segmented)

                        Button("Dodaj do listy") {
                            addEntry()
                        }
                        .disabled(enteredQuantity == nil)
                    }
                }
                
                VStack(alignment: .leading, spacing: 12){
                    Text("ADDED")
                        .font(.caption)
                        .fontWeight(.semibold)
                    ForEach(draftEntries) { entry in
                        HStack{
                            
                            Text(entry.system.rawValue)
                            
                            Spacer()
                            
                            Text("\(entry.quantity.formatted()) \(entry.unit.title)")
                            
                            Button(role: .destructive) {
                                draftEntries.removeAll() {$0.id == entry.id}
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        .padding()
                                .background(
                                    Color.gray.opacity(0.1),
                                    in: RoundedRectangle(cornerRadius: 10))
                    }
                }
                
                DisclosureGroup("Notes & inspection") {
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(3...6)

                    Toggle(
                        "Inspection required",
                        isOn: $requireInspection
                    )
                }
                TextField("Autor zapisu", text: $author)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

                if log.oilUplift != nil {
                    Text("Ten MaintLog ma już zapisane uzupełnienia. Edycja nie jest jeszcze dostępna.")
                        .foregroundStyle(.secondary)
                }

                Button {
                    saveEntries()
                } label: {
                    Text("Zapisz uzupełnienia")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .disabled(log.oilUplift != nil)

                Button("Anuluj", role: .cancel) {
                    dismiss()
                }
            }
            .padding()
            }
        }
        .alert(
            "Zapis uzupełnień",
            isPresented: Binding(
                get: { saveError != nil },
                set: { if !$0 { saveError = nil } }
            )
        ) {
            Button("OK", role: .cancel) { saveError = nil }
        } message: {
            Text(saveError ?? "")
        }
    }
}

#Preview {
    let data = try! MaintLogPreviewData.make()
    OIlSheetView(log: data.log)
        .modelContainer(data.container)
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
