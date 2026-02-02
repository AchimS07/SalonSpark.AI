//
//  SettingsView.swift
//  SalonSparkAI - Settings & Profile
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @State private var showEditProfile = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Salon Information") {
                    NavigationLink(destination: EditProfileView()) {
                        LabeledContent("Salon Name", value: appState.salonName)
                    }
                    LabeledContent("Owner", value: appState.ownerName)
                    LabeledContent("Phone", value: appState.phoneNumber)
                    LabeledContent("Email", value: appState.email)
                }
                
                Section("Business Hours") {
                    LabeledContent("Hours", value: appState.businessHours)
                }
                
                Section("Services") {
                    NavigationLink(destination: ServicesListView()) {
                        Label("Manage Services", systemImage: "scissors")
                    }
                }
                
                Section("Data") {
                    Button(action: exportData) {
                        Label("Export Data", systemImage: "square.and.arrow.up")
                    }
                    
                    Button(action: resetOnboarding) {
                        Label("Reset Onboarding", systemImage: "arrow.counterclockwise")
                    }
                }
                
                Section("About") {
                    LabeledContent("Version", value: "1.0.0")
                    LabeledContent("Build", value: "2026.02.01")
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    private func exportData() {
        let csv = appState.dataManager.exportToCSV(appointments: appState.appointments)
        UIPasteboard.general.string = csv
        appState.showSuccess("Data exported to clipboard")
    }
    
    private func resetOnboarding() {
        hasCompletedOnboarding = false
    }
}

struct EditProfileView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var salonName: String = ""
    @State private var ownerName: String = ""
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    
    var body: some View {
        Form {
            Section("Salon Details") {
                TextField("Salon Name", text: $salonName)
                TextField("Owner Name", text: $ownerName)
            }
            
            Section("Contact") {
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Address", text: $address)
            }
            
            Button("Save") {
                saveProfile()
            }
        }
        .navigationTitle("Edit Profile")
        .onAppear(perform: loadData)
    }
    
    private func loadData() {
        salonName = appState.salonName
        ownerName = appState.ownerName
        phone = appState.phoneNumber
        email = appState.email
        address = appState.address
    }
    
    private func saveProfile() {
        appState.salonName = salonName
        appState.ownerName = ownerName
        appState.phoneNumber = phone
        appState.email = email
        appState.address = address
        appState.showSuccess("Profile updated")
        dismiss()
    }
}

struct ServicesListView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List {
            ForEach(appState.services) { service in
                VStack(alignment: .leading, spacing: 4) {
                    Text(service.name)
                        .font(.headline)
                    Text(service.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    HStack {
                        Text(service.formattedPrice)
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(service.durationString)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Services")
    }
}
