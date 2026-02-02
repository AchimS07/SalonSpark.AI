//
//  Appointment.swift
//  SalonSparkAI
//
//  Appointment model with full functionality
//

import Foundation

enum AppointmentStatus: String, Codable, CaseIterable {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case completed = "Completed"
    case cancelled = "Cancelled"
    case noShow = "No Show"
}

struct Appointment: Identifiable, Codable {
    let id: String
    let clientId: String
    var clientName: String
    let serviceId: String
    var serviceName: String
    var date: Date
    var duration: Int // in minutes
    var status: AppointmentStatus
    var notes: String
    var reminderSent: Bool = false
    
    init(id: String = UUID().uuidString,
         clientId: String,
         clientName: String,
         serviceId: String,
         serviceName: String,
         date: Date,
         duration: Int,
         status: AppointmentStatus = .pending,
         notes: String = "",
         reminderSent: Bool = false) {
        self.id = id
        self.clientId = clientId
        self.clientName = clientName
        self.serviceId = serviceId
        self.serviceName = serviceName
        self.date = date
        self.duration = duration
        self.status = status
        self.notes = notes
        self.reminderSent = reminderSent
    }
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var endDate: Date {
        Calendar.current.date(byAdding: .minute, value: duration, to: date) ?? date
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(date)
    }
    
    var isPast: Bool {
        date < Date()
    }
}
