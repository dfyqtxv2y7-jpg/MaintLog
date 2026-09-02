//
//  MaintLogForm.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogForm: View {
    
    
    //--SWIFT DATA + ENV
    @Query(sort: \CustomerDataModel.name)
    private var customer: [CustomerDataModel]
    
    @Environment(\.modelContext)
    private var modelContext
    
    //--DATA MODEL
    @State private var departurePreviousAirport = ""
    @State private var departurePreviousTime: Date? = nil
    @State private var arrivalPreviousAirport: String? = nil
    @State private var arrivalPreviousTime: Date? = nil
    @State private var flightNumberPreviousFlight = ""
    @State private var departureScheduleAirport: String? = nil
    @State private var departureScheduleTime: Date? = nil
    @State private var arrivalScheduleAirport: String? = nil
    @State private var flightNumberScheduleFlight: String? = nil
    @State private var aircraftRegistration = ""
    @State private var aircraftType = ""
    @State private var aircraftSubType = ""
    @State private var referenceNo = ""
    @State private var station = ""
    @State private var status = "open"
    
    //--UI
    @State private var textSize: Int = 14
    
    //--CUSTOMER LOGIC
    @State private var showCustomerPicker = false
    @State private var selectedCustomerID: UUID? = nil
    @State private var customerSearch = ""
    
    private var selectedCustomer: CustomerDataModel? {
        customer.first {
            $0.id == selectedCustomerID
        }
    }
    
    
    var body: some View {
        ZStack{
            Color.theme.surfacePrimary
                .ignoresSafeArea()
            ScrollView {
                VStack{
                    HStack {
                        Text("Please Enter information about services")
                            .foregroundStyle(Color.theme.textSecondary)
                            .font(Font.default)
                            .padding(.horizontal, 20)
                        Spacer()
                    }
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.theme.borderDefault)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 325
                        )
                        .overlay(alignment: .topLeading) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Aircraft Information")
                                    .font(Font.title3)
                                    .fontWeight(.semibold)
                                
                                Divider()
                                
                                registrationForm()
                                
                                HStack{
                                    
                                aircraftTypeForm()
                                    
                                }
                                
                                clientForm()

                            }
                            .padding()
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                        }
                        .padding(.horizontal, 20)
                }
                .navigationTitle(Text("MaintLog"))
            }
        }
        
        .task {
            do {
                try CustomerSeedDB.CustomerDB(
                    into: modelContext
                )
            } catch {
                print(
                    "Customer seed error: \(error)"
                )
            }
        }
    }
}

#Preview {

    NavigationStack{
        MaintLogForm()
            .modelContainer(
                for: [
                    MaintLogDataModel.self,
                    CustomerDataModel.self
                ],
                inMemory: false
        )
    }
}

#Preview {

    NavigationStack{
        MaintLogForm()
            .modelContainer(
                for: [
                    MaintLogDataModel.self,
                    CustomerDataModel.self
                ],
                inMemory: false
        )
    }
    .environment(\.colorScheme, .dark)
}


extension MaintLogForm{
    
    private func registrationForm() -> some View{
        VStack(alignment: .leading) {
            Text("Aircraft Registration *")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            
            HStack(spacing: 5){
                Image(systemName: "airplane.path.dotted")
                Divider()
                    .frame(width: 5)
                TextField(
                    "np. SP-LRA",
                    text: $aircraftRegistration
                )
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.characters)
            }
            .padding(.horizontal)
            .frame(height: 45)
            .background(Color.theme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay{
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.borderDefault)
            }
        }
    }
    
    private func aircraftTypeForm() -> some View{
        VStack(alignment: .leading) {
            Text("Aircraft Type *")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            HStack(spacing: 5){
                Image(systemName: "airplane.path.dotted")
                Divider()
                    .frame(width: 5)
                TextField(
                    "np. B787",
                    text: $aircraftType
                )
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.characters)
            }
            .padding(.horizontal)
            .frame(height: 45)
            .background(Color.theme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay{
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.borderDefault)
                
            }
        }
    }
    
    private func clientForm() -> some View{
        VStack(alignment: .leading) {
                Text("Client *")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            
            Button{
                showCustomerPicker = true
            } label: {
                HStack(){
                    Image(systemName: "person.2")
                    
                    Divider()
                        .frame(width: 5)
                    
                    Text(
                        selectedCustomer?.name ?? "Choose client"
                    )
                    .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.caption)
                }
                .padding(.horizontal)
                .frame(height: 45)
                .background(Color.theme.fieldBackground)
                .clipShape(RoundedRectangle(cornerRadius: 14))
                .overlay{
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.theme.borderDefault)
                }
            }
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $showCustomerPicker) {
            customerPickerSheet
        }
    }
    
    private var customerPickerSheet: some View {
        NavigationStack {
            List(filteredCustomers, id: \.id) { customer in
                Button {
                    selectedCustomerID = customer.id
                    showCustomerPicker = false
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(customer.name)

                            Text(
                                "\(customer.iataCode) / \(customer.icaoCode)"
                            )
                            .font(.caption)
                            .foregroundStyle(
                                Color.theme.textSecondary
                            )
                        }

                        Spacer()

                        if selectedCustomerID == customer.id {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .overlay {
                if filteredCustomers.isEmpty {
                    ContentUnavailableView(
                        "Brak klientów",
                        systemImage: "person.2.slash",
                        description: Text(
                            customerSearch.isEmpty
                                ? "Baza klientów jest pusta."
                                : "Nie znaleziono pasującego klienta."
                        )
                    )
                }
            }
            .navigationTitle("Please Chose Client")
            .searchable(
                text: $customerSearch,
                prompt: "Find a client"
                
            )
        }
        .presentationDetents([.medium, .large])
    }
    
    private var filteredCustomers: [CustomerDataModel] {
        customer.filter { customer in
            customer.isActive &&
            (
                customerSearch.isEmpty ||
                customer.name.localizedCaseInsensitiveContains(
                    customerSearch
                ) ||
                customer.iataCode.localizedCaseInsensitiveContains(
                    customerSearch
                ) ||
                customer.icaoCode.localizedCaseInsensitiveContains(
                    customerSearch
                )
            )
        }
    }
}
