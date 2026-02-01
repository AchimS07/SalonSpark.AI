//
//  DashboardViewModel.swift
//  SalonSparkAI
//
//  ViewModel for dashboard data and business logic
//

import Foundation
import SwiftUI

class DashboardViewModel: ObservableObject {
    @Published var appointments: [Appointment] = Appointment.mockAppointments
    @Published var emptySlots: [EmptySlot] = EmptySlot.mockEmptySlots
    @Published var insights: [AIInsight] = AIInsight.mockInsights
    @Published var showToast = false
    @Published var toastMessage = ""
    
    // Stats
    let todaysBookings = 8
    let bookingsRemaining = 3
    let revenue = "$485"
    let newClients = 12
    let fillRate = "76%"
    let salonName = "Luxe Beauty Studio"
    let notificationCount = 3
    
    // Trends
    let bookingTrend = 12
    let clientTrend = 8
    
    func handleQuickAction(_ action: String) {
        toastMessage = "\(action) action triggered"
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    func promoteSlot(_ slotId: String) {
        toastMessage = "AI is generating a promotion for this slot..."
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    func handleInsightAction(_ insightId: String) {
        toastMessage = "Processing your request with AI..."
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
}
