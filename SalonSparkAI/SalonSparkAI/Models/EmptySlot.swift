//
//  EmptySlot.swift
//  SalonSparkAI
//
//  Empty time slot model
//

import Foundation

struct EmptySlot: Identifiable, Codable {
    let id: String
    let time: String
    let duration: String
    var service: String?
    
    init(id: String, time: String, duration: String, service: String? = nil) {
        self.id = id
        self.time = time
        self.duration = duration
        self.service = service
    }
}

// MARK: - Mock Data
extension EmptySlot {
    static let mockEmptySlots = [
        EmptySlot(id: "1", time: "10:00 AM", duration: "1 hour"),
        EmptySlot(id: "2", time: "2:00 PM", duration: "30 min"),
        EmptySlot(id: "3", time: "4:30 PM", duration: "45 min")
    ]
    
    static let emptySlots: [EmptySlot] = []  // For testing empty state
}
