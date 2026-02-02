//
//  QuickAction.swift
//  SalonSparkAI
//
//  Quick action button model
//

import SwiftUI

struct QuickAction: Identifiable {
    let id: String
    let icon: String
    let label: String
    let color: Color
    
    init(id: String, icon: String, label: String, color: Color) {
        self.id = id
        self.icon = icon
        self.label = label
        self.color = color
    }
}

// MARK: - Mock Data
extension QuickAction {
    static let defaultActions = [
        QuickAction(id: "booking", icon: "plus.circle.fill", label: "New Booking", color: .blue),
        QuickAction(id: "campaign", icon: "megaphone.fill", label: "Campaign", color: .amberAction),
        QuickAction(id: "offer", icon: "gift.fill", label: "Offer", color: .emeraldAction),
        QuickAction(id: "social", icon: "photo.on.rectangle", label: "Post", color: .pinkAction)
    ]
}
