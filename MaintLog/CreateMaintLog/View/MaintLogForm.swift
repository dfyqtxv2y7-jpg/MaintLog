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
    @State private var arrivalPreviousAirport = ""
    @State private var arrivalPreviousTime = Date()
    @State private var flightNumberPreviousFlight = ""
    @State private var departureScheduleAirport = ""
    @State private var departureScheduleTime = Date()
    @State private var arrivalScheduleAirport: String? = nil
    @State private var flightNumberScheduleFlight = ""
    @State private var aircraftRegistration = ""
    @State private var aircraftType = ""
    @State private var aircraftSubType = ""
    @State private var referenceNo = ""
    @State private var station = ""
    @State private var status = "open"
    
    //--ALERT
    @State private var showResetAlert = false
    
    //--CUSTOMER LOGIC
    @State private var showCustomerPicker = false
    @State private var selectedCustomerID: UUID? = nil
    @State private var customerSearch = ""
    
    private var selectedCustomer: CustomerDataModel? {
        customer.first {
            $0.id == selectedCustomerID
        }
    }
    
    //--VM/FUNC
    @StateObject private var viewModel = MaintLogFormVM()
    @State private var createdLog: MaintLogDataModel?
    
    
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
                    
                    aircraftInformationTable()
                    
                    arrivalInfoTab()
                    
                    departureInfoTab()
                                        
                    HStack {
                        
                        Button(role: .cancel){
                            resetButton()
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 100, height: 75)
                                .padding(.leading, 20)
                                .foregroundStyle(Color.theme.dangerForeground)
                                .overlay{
                                    Spacer()
                                    Text("Reset")
                                        .foregroundStyle(Color.theme.textInverse)
                                    Spacer()

                                    // do zmiany caly kontener
                                }
                        }
                        
                        //--
                        
                        //--
                        Button(role: .cancel){
                            createdLog = viewModel.saveMaintLogForm(
                                in: modelContext,
                                departurePreviousAirport: departurePreviousAirport,
                                departurePreviousTime: departurePreviousTime,
                                arrivalPreviousAirport: arrivalPreviousAirport,
                                arrivalPreviousTime: arrivalPreviousTime,
                                flightNumberPreviousFlight: flightNumberPreviousFlight,
                                departureScheduleAirport: departureScheduleAirport,
                                departureScheduleTime: departureScheduleTime,
                                arrivalScheduleAirport: arrivalScheduleAirport,
                                flightNumberScheduleFlight: flightNumberScheduleFlight,
                                aircraftRegistration: aircraftRegistration,
                                aircraftType: aircraftType,
                                aircraftSubType: aircraftSubType,
                                referenceNo: referenceNo,
                                station: station,
                                status: status,
                                customer: selectedCustomer?.name
                                )
                        } label: {
                            RoundedRectangle(cornerRadius: 25)
                                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 75)
                                .padding(.trailing, 20)
                                .foregroundStyle(Color.theme.actionPrimary)
                                .overlay{
                                    Spacer()
                                    Text("Create new MainLog")
                                        .foregroundStyle(Color.theme.textInverse)
                                    Spacer()
                            }
                        }
                        .navigationDestination(item: $createdLog) {
                            log in
                            MaintLogView(
                                log: log
                            )
                        }
                    }

                }
                .navigationTitle(Text("MaintLog"))
            }
            .alert("FORM HAS BEEN RESET", isPresented: $showResetAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("ALL FIELD HAS BEEN RESET")
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
    
    private func aircraftInformationTable() -> some View{
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
    
    private func arrivalInfoTab() -> some View{
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.theme.borderDefault)
            .frame(
                maxWidth: .infinity,
                minHeight: 290
            )
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Arrival Information")
                        .font(Font.title3)
                        .fontWeight(.semibold)
                    
                    Divider()

                    HStack(spacing: 0) {
                        
                        fromLabel()
                        
                        flightNoLabel()
                        
                    }
                    .padding(.horizontal, -15)
                    .padding(.top, -10)
                    
                    arrivalDateLabel()
                        .padding(.horizontal, 0)
                }
                    .padding(.horizontal,20)
                    .padding(.top, 10)
                
            }
            .padding(.horizontal, 20)
    }
    
    private func departureInfoTab() -> some View{
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.theme.borderDefault)
            .frame(
                maxWidth: .infinity,
                minHeight: 290
            )
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text("Depature Information")
                        .font(Font.title3)
                        .fontWeight(.semibold)
                    
                    Divider()

                    HStack(spacing: 0) {
                        
                        toLabel()
                        
                        flightNoLabelDep()
                        
                    }
                    .padding(.horizontal, -15)
                    .padding(.top, -10)
                    
                    arrivalDateLabel()
                        .padding(.horizontal, 0)
                    //do zmiany 
                }
                    .padding(.horizontal,20)
                    .padding(.top, 10)
                
            }
            .padding(.horizontal, 20)
    }
    
    private func fromLabel() -> some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("From")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            HStack(spacing: 5){
                Image(systemName: "airplane.arrival")
                Divider()
                    .frame(width: 5)
                TextField(
                    "WAW",
                    text: $arrivalPreviousAirport
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
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    private func  flightNoLabel() -> some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("Flight Number")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            HStack(spacing: 5){
                Image(systemName: "airplane.ticket")
                Divider()
                    .frame(width: 5)
                TextField(
                    "LO27",
                    text: $flightNumberPreviousFlight
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
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    private func arrivalDateLabel() -> some View{
        VStack(alignment: .leading){
            Text("Arrival Date")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
        
            HStack(alignment: .center ,spacing: 0){
                Spacer()
            Image(systemName: "airplane.ticket")
                    .scaleEffect(1.17)
                    .padding(.horizontal, 10)
                
            Divider()
                    .frame(width: 0)
                
            DatePicker("Select Date", selection: $arrivalPreviousTime)
                        .datePickerStyle(.wheel)
            }
            .scaleEffect(0.90)
            .padding(.horizontal)
            .frame(height: 75)
            .frame(minWidth: 325
                   , maxWidth: .infinity
            )
            .background(Color.theme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay{
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.borderDefault)
            }
        }
    }
    
    private func toLabel() -> some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("To")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            HStack(spacing: 5){
                Image(systemName: "airplane.departure")
                Divider()
                    .frame(width: 5)
                TextField(
                    "JFK",
                    text: $departureScheduleAirport
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
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    private func  flightNoLabelDep() -> some View{
        VStack(alignment: .leading, spacing: 10) {
            Text("Flight Number")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
            HStack(spacing: 5){
                Image(systemName: "airplane.ticket")
                Divider()
                    .frame(width: 5)
                TextField(
                    "LO2137",
                    text: $flightNumberScheduleFlight
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
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
    
    private func departureDateLabel() -> some View{
        VStack(alignment: .leading){
            Text("Departure Date")
                .foregroundStyle(Color.theme.textPrimary)
                .font(Font.callout)
                .fontWeight(.semibold)
        
            HStack(alignment: .center ,spacing: 0){
                Spacer()
            Image(systemName: "airplane.ticket")
                    .scaleEffect(1.17)
                    .padding(.horizontal, 10)
                
            Divider()
                    .frame(width: 0)
                
            DatePicker("Select Date", selection: $departureScheduleTime)
                        .datePickerStyle(.wheel)
            }
            .scaleEffect(0.90)
            .padding(.horizontal)
            .frame(height: 75)
            .frame(minWidth: 325
                   , maxWidth: .infinity
            )
            .background(Color.theme.fieldBackground)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay{
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.borderDefault)
            }
        }
    }
    
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
    
    //--  RESET BUTTON
    
    private func resetButton() {
         departurePreviousAirport = ""
         departurePreviousTime = Date()
         arrivalPreviousAirport = ""
         arrivalPreviousTime = Date()
         flightNumberPreviousFlight = ""
         departureScheduleAirport = ""
         departureScheduleTime = Date()
         arrivalScheduleAirport = ""
         flightNumberScheduleFlight = ""
         aircraftRegistration = ""
         aircraftType = ""
         aircraftSubType = ""
         referenceNo = ""
         station = ""
         status = "open"
         customerSearch = ""
        
         showResetAlert = true
    }
}
