//
//  AppState.swift
//  SalonSparkAI
//
//  Global app state managing all data
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedTab = "home"
    @Published var appointments: [Appointment] = []
    @Published var clients: [Client] = []
    @Published var services: [Service] = []
    @Published var campaigns: [Campaign] = []
    
    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var toastIcon = "checkmark.circle.fill"
    
    // Settings
    @Published var salonName = "Luxe Beauty Studio"
    @Published var ownerName = "Your Name"
    @Published var businessHours = "9:00 AM - 7:00 PM"
    @Published var phoneNumber = "+1 (555) 123-4567"
    @Published var email = "contact@luxebeauty.com"
    @Published var address = "123 Main Street, City, State 12345"
    
    // Services
    let aiService = AIService()
    let dataManager = DataManager()
    
    init() {
        loadMockData()
    }
    
    // MARK: - Appointment Management
    func addAppointment(_ appointment: Appointment) {
        appointments.append(appointment)
        appointments.sort { $0.date < $1.date }
        showSuccess("Appointment booked for \(appointment.clientName)")
    }
    
    func updateAppointment(_ appointment: Appointment) {
        if let index = appointments.firstIndex(where: { $0.id == appointment.id }) {
            appointments[index] = appointment
            showSuccess("Appointment updated")
        }
    }
    
    func deleteAppointment(_ appointment: Appointment) {
        appointments.removeAll { $0.id == appointment.id }
        showSuccess("Appointment cancelled")
    }
    
    func getAppointments(for date: Date) -> [Appointment] {
        let calendar = Calendar.current
        return appointments.filter { appointment in
            calendar.isDate(appointment.date, inSameDayAs: date)
        }
    }
    
    // MARK: - Client Management
    func addClient(_ client: Client) {
        clients.append(client)
        showSuccess("Client \(client.name) added")
    }
    
    func updateClient(_ client: Client) {
        if let index = clients.firstIndex(where: { $0.id == client.id }) {
            clients[index] = client
            showSuccess("Client updated")
        }
    }
    
    func deleteClient(_ client: Client) {
        clients.removeAll { $0.id == client.id }
        showSuccess("Client deleted")
    }
    
    // MARK: - Campaign Management
    func addCampaign(_ campaign: Campaign) {
        campaigns.append(campaign)
        showSuccess("Campaign created")
    }
    
    // MARK: - Stats
    var todayAppointments: [Appointment] {
        getAppointments(for: Date())
    }
    
    var todayRevenue: Double {
        todayAppointments.reduce(0) { total, appointment in
            let service = services.first { $0.id == appointment.serviceId }
            return total + (service?.price ?? 0)
        }
    }
    
    var weekClients: Int {
        let calendar = Calendar.current
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        return clients.filter { $0.createdAt > weekAgo }.count
    }
    
    var monthlyFillRate: Double {
        let calendar = Calendar.current
        let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
        let monthAppointments = appointments.filter { $0.date > monthAgo }
        
        // Assuming 10 slots per day, 30 days
        let totalSlots = 10 * 30
        return Double(monthAppointments.count) / Double(totalSlots)
    }
    
    // MARK: - Toast Notifications
    func showSuccess(_ message: String) {
        toastMessage = message
        toastIcon = "checkmark.circle.fill"
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.showToast = false
        }
    }
    
    func showError(_ message: String) {
        toastMessage = message
        toastIcon = "exclamationmark.triangle.fill"
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.showToast = false
        }
    }
    
    // MARK: - Mock Data
    private func loadMockData() {
        // Load services
        services = Service.sampleServices
        
        // Load clients
        clients = Client.sampleClients
        
        // Load appointments
        let calendar = Calendar.current
        let today = Date()
        
        appointments = [
            Appointment(
                id: UUID().uuidString,
                clientId: clients[0].id,
                clientName: clients[0].name,
                serviceId: services[0].id,
                serviceName: services[0].name,
                date: calendar.date(byAdding: .hour, value: 1, to: today)!,
                duration: 60,
                status: .confirmed,
                notes: ""
            ),
            Appointment(
                id: UUID().uuidString,
                clientId: clients[1].id,
                clientName: clients[1].name,
                serviceId: services[1].id,
                serviceName: services[1].name,
                date: calendar.date(byAdding: .hour, value: 3, to: today)!,
                duration: 120,
                status: .confirmed,
                notes: ""
            ),
            Appointment(
                id: UUID().uuidString,
                clientId: clients[2].id,
                clientName: clients[2].name,
                serviceId: services[2].id,
                serviceName: services[2].name,
                date: calendar.date(byAdding: .hour, value: 5, to: today)!,
                duration: 45,
                status: .confirmed,
                notes: ""
            )
        ]
    }
}
