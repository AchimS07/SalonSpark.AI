//
//  ContentView.swift
//  SalonSparkAI
//
//  Main content view that handles navigation between onboarding and dashboard
//

import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    
    var body: some View {
        if showOnboarding {
            OnboardingView(onComplete: {
                showOnboarding = false
            })
        } else {
            DashboardView()
        }
    }
}

#Preview {
    ContentView()
}
