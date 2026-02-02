//
//  ContentView.swift
//  SalonSparkAI
//
//  Main app view with tab navigation
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                MainTabView()
            } else {
                OnboardingView(onComplete: {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                })
            }
        }
        .overlay(alignment: .bottom) {
            if appState.showToast {
                ToastView(message: appState.toastMessage, icon: appState.toastIcon)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(), value: appState.showToast)
                    .padding(.bottom, 100)
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag("home")
            
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
                .tag("calendar")
            
            AIBoostView()
                .tabItem {
                    Label("AI Boost", systemImage: "sparkles")
                }
                .tag("ai")
            
            ClientsView()
                .tabItem {
                    Label("Clients", systemImage: "person.2.fill")
                }
                .tag("clients")
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag("settings")
        }
    }
}

struct ToastView: View {
    let message: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
            Text(message)
                .font(.subheadline)
                .fontWeight(.medium)
        }
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(
            Capsule()
                .fill(Color.black.opacity(0.85))
        )
        .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
