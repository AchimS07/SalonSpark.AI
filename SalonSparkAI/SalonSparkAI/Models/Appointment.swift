//
//  Appointment.swift
//  SalonSparkAI
//
//  Appointment data model
//

import Foundation

struct Appointment: Identifiable, Codable {
    let id: String
    let clientName: String
    let service: String
    let time: String
    var avatar: String?
    
    init(id: String, clientName: String, service: String, time: String, avatar: String? = nil) {
        self.id = id
        self.clientName = clientName
        self.service = service
        self.time = time
        self.avatar = avatar
    }
}

// MARK: - Mock Data
extension Appointment {
    static let mockAppointments = [
        Appointment(id: "1", clientName: "Sarah Johnson", service: "Hair Color & Cut", time: "9:00 AM"),
        Appointment(id: "2", clientName: "Emma Williams", service: "Balayage", time: "11:30 AM"),
        Appointment(id: "3", clientName: "Olivia Brown", service: "Blowout", time: "1:00 PM"),
        Appointment(id: "4", clientName: "Ava Davis", service: "Extensions", time: "3:30 PM"),
        Appointment(id: "5", clientName: "Mia Martinez", service: "Hair Treatment", time: "5:00 PM")
    ]
}
