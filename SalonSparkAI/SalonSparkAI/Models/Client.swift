//
//  Client.swift
//  SalonSparkAI
//
//  Client model with contact info and history
//

import Foundation

struct Client: Identifiable, Codable {
    let id: String
    var name: String
    var email: String
    var phone: String
    var notes: String
    var totalVisits: Int
    var totalSpent: Double
    var createdAt: Date
    var lastVisit: Date?
    var preferredServices: [String]
    var birthday: Date?
    
    init(id: String = UUID().uuidString,
         name: String,
         email: String,
         phone: String,
         notes: String = "",
         totalVisits: Int = 0,
         totalSpent: Double = 0,
         createdAt: Date = Date(),
         lastVisit: Date? = nil,
         preferredServices: [String] = [],
         birthday: Date? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.notes = notes
        self.totalVisits = totalVisits
        self.totalSpent = totalSpent
        self.createdAt = createdAt
        self.lastVisit = lastVisit
        self.preferredServices = preferredServices
        self.birthday = birthday
    }
    
    var initials: String {
        let components = name.components(separatedBy: " ")
        let initials = components.compactMap { $0.first }.map { String($0) }
        return initials.prefix(2).joined()
    }
    
    var isVIP: Bool {
        totalVisits >= 10 || totalSpent >= 1000
    }
    
    static let sampleClients = [
        Client(
            name: "Sarah Johnson",
            email: "sarah.j@email.com",
            phone: "+1 (555) 123-4567",
            notes: "Prefers morning appointments",
            totalVisits: 15,
            totalSpent: 1250.00,
            lastVisit: Date(),
            preferredServices: ["Hair Color", "Cut"]
        ),
        Client(
            name: "Emma Williams",
            email: "emma.w@email.com",
            phone: "+1 (555) 234-5678",
            notes: "Allergic to certain hair products",
            totalVisits: 8,
            totalSpent: 680.00,
            lastVisit: Calendar.current.date(byAdding: .day, value: -7, to: Date()),
            preferredServices: ["Balayage"]
        ),
        Client(
            name: "Olivia Brown",
            email: "olivia.b@email.com",
            phone: "+1 (555) 345-6789",
            notes: "",
            totalVisits: 5,
            totalSpent: 350.00,
            lastVisit: Calendar.current.date(byAdding: .day, value: -14, to: Date()),
            preferredServices: ["Blowout"]
        ),
        Client(
            name: "Ava Davis",
            email: "ava.d@email.com",
            phone: "+1 (555) 456-7890",
            notes: "Always books extensions",
            totalVisits: 12,
            totalSpent: 1800.00,
            lastVisit: Calendar.current.date(byAdding: .day, value: -3, to: Date()),
            preferredServices: ["Extensions"]
        ),
        Client(
            name: "Mia Martinez",
            email: "mia.m@email.com",
            phone: "+1 (555) 567-8901",
            notes: "New client",
            totalVisits: 1,
            totalSpent: 75.00,
            lastVisit: Calendar.current.date(byAdding: .day, value: -30, to: Date()),
            preferredServices: ["Hair Treatment"]
        )
    ]
}
