//
//  DashboardView.swift
//  SalonSparkAI
//
//  Main dashboard view with stats, appointments, and AI insights
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.orange.opacity(0.1), Color.pink.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        HeaderView(
                            salonName: viewModel.salonName,
                            notificationCount: viewModel.notificationCount
                        )
                        
                        // Stats Grid
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            StatsCardView(
                                title: "Today's Bookings",
                                value: "\(viewModel.todaysBookings)",
                                subtitle: "\(viewModel.bookingsRemaining) remaining",
                                icon: "calendar",
                                trend: viewModel.bookingTrend,
                                isPositive: true
                            )
                            
                            StatsCardView(
                                title: "Revenue",
                                value: viewModel.revenue,
                                subtitle: "Today's total",
                                icon: "dollarsign.circle.fill",
                                isPrimary: true
                            )
                            
                            StatsCardView(
                                title: "New Clients",
                                value: "\(viewModel.newClients)",
                                subtitle: "This week",
                                icon: "person.2.fill",
                                trend: viewModel.clientTrend,
                                isPositive: true
                            )
                            
                            StatsCardView(
                                title: "Fill Rate",
                                value: viewModel.fillRate,
                                subtitle: "This month",
                                icon: "chart.bar.fill"
                            )
                        }
                        .padding(.horizontal)
                        
                        // Quick Actions
                        QuickActionsView(onAction: viewModel.handleQuickAction)
                        
                        // Empty Slots
                        EmptySlotsView(
                            slots: viewModel.emptySlots,
                            onPromote: viewModel.promoteSlot
                        )
                        
                        // AI Insights
                        AIInsightsView(
                            insights: viewModel.insights,
                            onAction: viewModel.handleInsightAction
                        )
                        
                        // Upcoming Appointments
                        UpcomingAppointmentsView(appointments: viewModel.appointments)
                    }
                    .padding(.bottom, 80)
                }
                
                // Toast notification
                if viewModel.showToast {
                    VStack {
                        Spacer()
                        Text(viewModel.toastMessage)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                            .padding(.bottom, 100)
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: viewModel.showToast)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Quick Actions View
struct QuickActionsView: View {
    let onAction: (String) -> Void
    
    let actions = [
        ("calendar.badge.plus", "New Booking"),
        ("wand.and.stars", "AI Post"),
        ("chart.line.uptrend.xyaxis", "Analytics"),
        ("person.badge.plus", "Add Client")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(actions, id: \.1) { icon, title in
                        Button(action: { onAction(title) }) {
                            VStack(spacing: 8) {
                                Image(systemName: icon)
                                    .font(.title2)
                                    .foregroundColor(.blue)
                                Text(title)
                                    .font(.caption)
                                    .foregroundColor(.primary)
                            }
                            .frame(width: 100, height: 80)
                            .background(Color(UIColor.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 4)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// Empty Slots View
struct EmptySlotsView: View {
    let slots: [EmptySlot]
    let onPromote: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Empty Slots")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 8) {
                ForEach(slots) { slot in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(slot.time)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(slot.duration)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: { onPromote(slot.id) }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Promote")
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
    }
}

// AI Insights View
struct AIInsightsView: View {
    let insights: [AIInsight]
    let onAction: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.purple)
                Text("AI Insights")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            VStack(spacing: 12) {
                ForEach(insights) { insight in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: iconForInsightType(insight.type))
                                .foregroundColor(colorForInsightType(insight.type))
                            Text(insight.title)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                        Text(insight.description)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text(insight.impact)
                                .font(.caption2)
                                .foregroundColor(.green)
                            
                            Spacer()
                            
                            Button(action: { onAction(insight.id) }) {
                                Text(insight.action)
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
    }
    
    func iconForInsightType(_ type: InsightType) -> String {
        switch type {
        case .promotion: return "tag.fill"
        case .content: return "photo.fill"
        case .timing: return "clock.fill"
        }
    }
    
    func colorForInsightType(_ type: InsightType) -> Color {
        switch type {
        case .promotion: return .orange
        case .content: return .blue
        case .timing: return .purple
        }
    }
}

// Upcoming Appointments View
struct UpcomingAppointmentsView: View {
    let appointments: [Appointment]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming Appointments")
                .font(.headline)
                .padding(.horizontal)
            
            VStack(spacing: 8) {
                ForEach(appointments) { appointment in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(appointment.clientName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                            Text(appointment.service)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Text(appointment.time)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    DashboardView()
}
