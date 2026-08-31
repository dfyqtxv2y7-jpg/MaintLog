//
//  MaintLogForm.swift
//  MaintLog
//
//  Created by Maciek Witanowski on 29/08/2026.
//

import SwiftUI
import SwiftData

struct MaintLogForm: View {
    
    @Query(sort: \CustomerDataModel.name)
    private var customer: [CustomerDataModel]
    
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
    
    //--CUSTOMER LOGIC
    
    
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
                            minHeight: 220
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
                                    
                                clientForm()
                                }
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
                inMemory: true
            )
    }
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
    
//    private func clientForm() -> some View{
//        VStack(alignment: .leading) {
//            Picker("Client", selection: $customer){
//                
//            }
////            Text("Aircraft Type *")
////                .foregroundStyle(Color.theme.textPrimary)
////                .font(Font.callout)
////                .fontWeight(.semibold)
////            HStack(spacing: 5){
////                Image(systemName: "airplane.path.dotted")
////                Divider()
////                    .frame(width: 5)
////                TextField(
////                    "np. B787",
////                    text: $aircraftType
////                )
////                .autocorrectionDisabled(true)
////                .textInputAutocapitalization(.characters)
////            }
////            .padding(.horizontal)
////            .frame(height: 45)
////            .background(Color.theme.fieldBackground)
////            .clipShape(RoundedRectangle(cornerRadius: 14))
////            .overlay{
////                RoundedRectangle(cornerRadius: 14)
////                    .stroke(Color.theme.borderDefault)
////                
////            }
//        }
//    }
}
