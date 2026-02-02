//
//  DashboardView.swift
//  SalonSparkAI
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var showBookingForm = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Stats Grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        StatCard(title: "Today's Bookings", value: "\(appState.todayAppointments.count)", icon: "calendar", color: .blue)
                        StatCard(title: "Revenue", value: appState.todayRevenue.currencyString, icon: "dollarsign.circle.fill", color: .green)
                        StatCard(title: "New Clients", value: "\(appState.weekClients)", icon: "person.2.fill", color: .purple)
                        StatCard(title: "Fill Rate", value: String(format: "%.0f%%", appState.monthlyFillRate * 100), icon: "chart.bar.fill", color: .orange)
                    }
                    .padding(.horizontal)
                    
                    // Quick Actions
                    QuickActionsSection(showBookingForm: $showBookingForm)
                    
                    // Today's Appointments
                    TodayAppointmentsSection()
                    
                    // AI Insights
                    AIInsightsSection()
                }
                .padding(.vertical)
            }
            .navigationTitle("Dashboard")
            .sheet(isPresented: $showBookingForm) {
                BookingFormView()
            }
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                Spacer()
            }
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct QuickActionsSection: View {
    @Binding var showBookingForm: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                QuickActionButton(icon: "plus.circle.fill", title: "Book", color: .blue) {
                    showBookingForm = true
                }
                QuickActionButton(icon: "megaphone.fill", title: "Campaign", color: .orange) {
                    appState.selectedTab = "ai"
                }
                QuickActionButton(icon: "gift.fill", title: "Offer", color: .green) {
                    appState.selectedTab = "ai"
                }
                QuickActionButton(icon: "photo.fill", title: "Post", color: .pink) {
                    appState.selectedTab = "ai"
                }
            }
            .padding(.horizontal)
        }
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(color)
                    .clipShape(Circle())
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct TodayAppointmentsSection: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Today's Appointments")
                .font(.headline)
                .padding(.horizontal)
            
            if appState.todayAppointments.isEmpty {
                Text("No appointments scheduled")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(appState.todayAppointments) { appointment in
                    AppointmentRow(appointment: appointment)
                }
                .padding(.horizontal)
            }
        }
    }
}

struct AppointmentRow: View {
    let appointment: Appointment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.clientName)
                    .font(.headline)
                Text(appointment.serviceName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(appointment.timeString)
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

struct AIInsightsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("AI Insights")
                .font(.headline)
                .padding(.horizontal)
            
            InsightCard(
                title: "Empty Slot Alert",
                description: "You have 3 empty slots today. Create a flash sale?",
                action: "Promote Slots"
            )
            
            InsightCard(
                title: "Client Follow-up",
                description: "5 VIP clients haven't booked in 30 days",
                action: "Send Offers"
            )
        }
    }
}

struct InsightCard: View {
    let title: String
    let description: String
    let action: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.purple)
                Text(title)
                    .font(.headline)
            }
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Button(action: {}) {
                Text(action)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
