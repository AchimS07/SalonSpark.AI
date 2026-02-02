//
//  ContentView.swift
//  SalonSparkAI
//
//  Main content view handling navigation between onboarding and dashboard
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    
    var body: some View {
        Group {
            if hasCompletedOnboarding {
                DashboardView()
            } else {
                OnboardingView(onComplete: {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                })
            }
        }
    }
}

#Preview {
    ContentView()
}
