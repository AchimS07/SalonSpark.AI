//
//  ClientsView.swift
//  SalonSparkAI - Client Management
//

import SwiftUI

struct ClientsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = ClientsViewModel()
    @State private var showAddClient = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search clients...", text: $viewModel.searchText)
                }
                .padding(10)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Filter Picker
                Picker("Filter", selection: $viewModel.selectedFilter) {
                    ForEach(ClientFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue).tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Client List
                List {
                    ForEach(viewModel.filteredClients(appState.clients)) { client in
                        NavigationLink(destination: ClientDetailView(client: client)) {
                            ClientRow(client: client)
                        }
                    }
                    .onDelete(perform: deleteClients)
                }
            }
            .navigationTitle("Clients")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showAddClient = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddClient) {
                AddClientView()
            }
        }
    }
    
    private func deleteClients(at offsets: IndexSet) {
        let filtered = viewModel.filteredClients(appState.clients)
        offsets.forEach { index in
            let client = filtered[index]
            appState.deleteClient(client)
        }
    }
}

struct ClientRow: View {
    let client: Client
    
    var body: some View {
        HStack {
            // Avatar
            Circle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(client.initials)
                        .font(.headline)
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(client.name)
                        .font(.headline)
                    if client.isVIP {
                        Text("VIP")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.yellow)
                            .cornerRadius(4)
                    }
                }
                Text(client.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(client.totalVisits) visits • \(client.totalSpent.currencyString)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

struct AddClientView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal Information") {
                    TextField("Name", text: $name)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    TextField("Phone", text: $phone)
                        .keyboardType(.phonePad)
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Button("Add Client") {
                    saveClient()
                }
                .disabled(name.isEmpty || email.isEmpty)
            }
            .navigationTitle("Add Client")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
    
    private func saveClient() {
        let client = Client(
            name: name,
            email: email,
            phone: phone,
            notes: notes
        )
        appState.addClient(client)
        dismiss()
    }
}

struct ClientDetailView: View {
    let client: Client
    @EnvironmentObject var appState: AppState
    
    var clientAppointments: [Appointment] {
        appState.appointments.filter { $0.clientId == client.id }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        List {
            Section("Information") {
                LabeledContent("Email", value: client.email)
                LabeledContent("Phone", value: client.phone)
                LabeledContent("Total Visits", value: "\(client.totalVisits)")
                LabeledContent("Total Spent", value: client.totalSpent.currencyString)
                if client.isVIP {
                    Label("VIP Client", systemImage: "star.fill")
                        .foregroundColor(.yellow)
                }
            }
            
            if !client.notes.isEmpty {
                Section("Notes") {
                    Text(client.notes)
                }
            }
            
            Section("Appointment History") {
                if clientAppointments.isEmpty {
                    Text("No appointments yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(clientAppointments) { appointment in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appointment.serviceName)
                                .font(.headline)
                            Text(appointment.date.shortDateString)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .navigationTitle(client.name)
    }
}
