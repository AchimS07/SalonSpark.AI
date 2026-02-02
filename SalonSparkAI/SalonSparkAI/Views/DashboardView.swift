//
//  DashboardView.swift
//  SalonSparkAI
//
//  Main dashboard with all components
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient.warmBackground
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HeaderView(
                    salonName: viewModel.salonName,
                    notificationCount: viewModel.notificationCount,
                    onSearch: viewModel.handleSearch,
                    onNotifications: viewModel.handleNotifications
                )
                
                // Main content
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Stats grid
                        statsGrid
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        
                        // Quick actions
                        VStack(alignment: .leading, spacing: 12) {
                            QuickActionsView(
                                actions: viewModel.quickActions,
                                onAction: viewModel.handleQuickAction
                            )
                        }
                        .padding(.horizontal, 16)
                        
                        // Empty slots
                        EmptySlotsView(
                            slots: viewModel.emptySlots,
                            onPromote: viewModel.promoteSlot,
                            onPromoteAll: viewModel.promoteAllSlots
                        )
                        .padding(.horizontal, 16)
                        
                        // AI insights
                        AIInsightsView(
                            insights: viewModel.insights,
                            onAction: viewModel.handleInsightAction,
                            onViewAll: viewModel.viewAllInsights
                        )
                        .padding(.horizontal, 16)
                        
                        // Upcoming appointments
                        UpcomingAppointmentsView(
                            appointments: viewModel.appointments,
                            onViewAll: viewModel.viewAllAppointments
                        )
                        .padding(.horizontal, 16)
                        
                        // Bottom spacing for nav bar
                        Color.clear.frame(height: 80)
                    }
                }
                .refreshable {
                    viewModel.refreshData()
                }
            }
            
            // Bottom navigation
            VStack {
                Spacer()
                MobileNavView(
                    activeTab: $viewModel.activeTab,
                    onTabChange: viewModel.changeTab
                )
            }
            .ignoresSafeArea(edges: .bottom)
            
            // Toast notification
            if viewModel.showToast {
                VStack {
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Image(systemName: viewModel.toastIcon)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Text(viewModel.toastMessage)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 14)
                    .background(
                        Capsule()
                            .fill(Color.black.opacity(0.85))
                    )
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 4)
                    .padding(.bottom, 100)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.showToast)
            }
        }
        .sheet(isPresented: $viewModel.showSearchSheet) {
            searchSheetContent
        }
        .sheet(isPresented: $viewModel.showNotificationsSheet) {
            notificationsSheetContent
        }
    }
    
    // MARK: - Stats Grid
    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
            StatsCardView(
                title: "Today's Bookings",
                value: "\(viewModel.todaysBookings)",
                subtitle: "\(viewModel.bookingsRemaining) remaining",
                icon: "calendar",
                trend: (value: viewModel.bookingTrend, isPositive: viewModel.bookingTrendPositive)
            )
            
            StatsCardView(
                title: "Revenue",
                value: viewModel.revenue,
                subtitle: "Today's total",
                icon: "dollarsign.circle.fill",
                variant: .primary
            )
            
            StatsCardView(
                title: "New Clients",
                value: "\(viewModel.newClients)",
                subtitle: "This week",
                icon: "person.2.fill",
                trend: (value: viewModel.clientTrend, isPositive: viewModel.clientTrendPositive)
            )
            
            StatsCardView(
                title: "Fill Rate",
                value: viewModel.fillRate,
                subtitle: "This month",
                icon: "chart.bar.fill"
            )
        }
    }
    
    // MARK: - Sheet Content
    private var searchSheetContent: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 48))
                    .foregroundColor(.secondary)
                
                Text("Search Feature")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Search functionality coming soon!")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.showSearchSheet = false
                    }
                }
            }
        }
    }
    
    private var notificationsSheetContent: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.blue)
                
                Text("\(viewModel.notificationCount) New Notifications")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Notification center coming soon!")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        viewModel.showNotificationsSheet = false
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
