//
//  BookingFormView.swift
//  SalonSparkAI - Functional Booking Form
//

import SwiftUI

struct BookingFormView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var preselectedDate: Date?
    
    @State private var selectedClientId: String?
    @State private var selectedServiceId: String?
    @State private var appointmentDate = Date()
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section("Client") {
                    Picker("Select Client", selection: $selectedClientId) {
                        Text("Select...").tag(nil as String?)
                        ForEach(appState.clients) { client in
                            Text(client.name).tag(client.id as String?)
                        }
                    }
                }
                
                Section("Service") {
                    Picker("Select Service", selection: $selectedServiceId) {
                        Text("Select...").tag(nil as String?)
                        ForEach(appState.services) { service in
                            Text("\(service.name) - \(service.formattedPrice)").tag(service.id as String?)
                        }
                    }
                }
                
                Section("Date & Time") {
                    DatePicker("Appointment Time", selection: $appointmentDate, in: Date()...)
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
                
                Section {
                    Button("Book Appointment") {
                        bookAppointment()
                    }
                    .disabled(selectedClientId == nil || selectedServiceId == nil)
                }
            }
            .navigationTitle("New Booking")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear {
                if let date = preselectedDate {
                    appointmentDate = date
                }
            }
        }
    }
    
    private func bookAppointment() {
        guard let clientId = selectedClientId,
              let serviceId = selectedServiceId,
              let client = appState.clients.first(where: { $0.id == clientId }),
              let service = appState.services.first(where: { $0.id == serviceId }) else { return }
        
        let appointment = Appointment(
            clientId: client.id,
            clientName: client.name,
            serviceId: service.id,
            serviceName: service.name,
            date: appointmentDate,
            duration: service.duration,
            status: .confirmed,
            notes: notes
        )
        
        appState.addAppointment(appointment)
        dismiss()
    }
}
