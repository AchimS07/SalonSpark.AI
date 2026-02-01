//
//  Appointment.swift
//  SalonSparkAI
//
//  Model for appointment data
//

import Foundation

struct Appointment: Identifiable {
    let id: String
    let clientName: String
    let service: String
    let time: String
}

// Mock data
extension Appointment {
    static let mockAppointments = [
        Appointment(id: "1", clientName: "Sarah Johnson", service: "Hair Color & Cut", time: "9:00 AM"),
        Appointment(id: "2", clientName: "Emma Williams", service: "Balayage", time: "11:30 AM"),
        Appointment(id: "3", clientName: "Olivia Brown", service: "Blowout", time: "1:00 PM"),
        Appointment(id: "4", clientName: "Ava Davis", service: "Extensions", time: "3:30 PM")
    ]
}
