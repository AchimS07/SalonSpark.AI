//
//  EmptySlot.swift
//  SalonSparkAI
//
//  Model for empty time slots
//

import Foundation

struct EmptySlot: Identifiable {
    let id: String
    let time: String
    let duration: String
}

// Mock data
extension EmptySlot {
    static let mockEmptySlots = [
        EmptySlot(id: "1", time: "10:00 AM", duration: "1 hour"),
        EmptySlot(id: "2", time: "2:00 PM", duration: "30 min"),
        EmptySlot(id: "3", time: "4:30 PM", duration: "45 min")
    ]
}
