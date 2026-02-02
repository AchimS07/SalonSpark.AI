//
//  DashboardViewModel.swift
//  SalonSparkAI
//
//  Dashboard view model with business logic
//

import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var appointments: [Appointment] = Appointment.mockAppointments
    @Published var emptySlots: [EmptySlot] = EmptySlot.mockEmptySlots
    @Published var insights: [AIInsight] = AIInsight.mockInsights
    @Published var quickActions: [QuickAction] = QuickAction.defaultActions
    
    @Published var showToast = false
    @Published var toastMessage = ""
    @Published var toastIcon = "checkmark.circle.fill"
    
    @Published var activeTab = "home"
    @Published var showSearchSheet = false
    @Published var showNotificationsSheet = false
    
    // MARK: - Stats Properties
    let salonName = "Luxe Beauty Studio"
    let notificationCount = 3
    
    var todaysBookings: Int {
        appointments.count
    }
    
    var bookingsRemaining: Int {
        max(0, 12 - appointments.count)
    }
    
    let revenue = "$485"
    let todaysRevenue = 485.0
    
    let newClients = 12
    let newClientsThisWeek = 12
    
    let fillRate = "76%"
    let fillRateValue = 0.76
    
    // MARK: - Trends
    let bookingTrend = 12
    let bookingTrendPositive = true
    
    let revenueTrend = 8
    let revenueTrendPositive = true
    
    let clientTrend = 8
    let clientTrendPositive = true
    
    let fillRateTrend = 5
    let fillRateTrendPositive = true
    
    // MARK: - Actions
    func handleQuickAction(_ actionId: String) {
        let actionNames: [String: String] = [
            "booking": "New Booking",
            "campaign": "Campaign",
            "offer": "Offer",
            "social": "Social Post"
        ]
        
        let actionName = actionNames[actionId] ?? actionId
        showToastMessage("\(actionName) action triggered", icon: "checkmark.circle.fill")
        
        // Add haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    func promoteSlot(_ slotId: String) {
        showToastMessage("AI is generating a promotion for this slot...", icon: "sparkles")
        
        // Simulate AI processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showToastMessage("Promotion created successfully!", icon: "checkmark.circle.fill")
        }
    }
    
    func promoteAllSlots() {
        guard !emptySlots.isEmpty else { return }
        showToastMessage("AI is creating promotions for \(emptySlots.count) slots...", icon: "sparkles")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showToastMessage("All promotions created!", icon: "checkmark.circle.fill")
        }
    }
    
    func handleInsightAction(_ insightId: String) {
        if let insight = insights.first(where: { $0.id == insightId }) {
            showToastMessage("Processing: \(insight.action)...", icon: "sparkles")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.showToastMessage("\(insight.action) completed!", icon: "checkmark.circle.fill")
            }
        }
    }
    
    func viewAllInsights() {
        showToastMessage("Opening all AI suggestions...", icon: "sparkles")
    }
    
    func viewAllAppointments() {
        showToastMessage("Opening full schedule...", icon: "calendar")
    }
    
    func handleSearch() {
        showSearchSheet = true
    }
    
    func handleNotifications() {
        showNotificationsSheet = true
    }
    
    func changeTab(to tab: String) {
        withAnimation {
            activeTab = tab
        }
        showToastMessage("Switched to \(tab.capitalized)", icon: tabIcon(for: tab))
    }
    
    private func tabIcon(for tab: String) -> String {
        switch tab {
        case "home": return "house.fill"
        case "calendar": return "calendar"
        case "ai": return "sparkles"
        case "clients": return "person.2.fill"
        case "settings": return "gearshape.fill"
        default: return "checkmark.circle.fill"
        }
    }
    
    // MARK: - Toast Helper
    private func showToastMessage(_ message: String, icon: String) {
        toastMessage = message
        toastIcon = icon
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation {
                self.showToast = false
            }
        }
    }
    
    // MARK: - Data Refresh
    func refreshData() {
        // Simulate data refresh
        showToastMessage("Refreshing data...", icon: "arrow.clockwise")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showToastMessage("Data updated!", icon: "checkmark.circle.fill")
        }
    }
}
