//
//  OnboardingView.swift
//  SalonSparkAI
//

import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                OnboardingPage(icon: "sparkles", title: "AI-Powered Growth", description: "Let AI help you fill slots and grow your business")
                    .tag(0)
                OnboardingPage(icon: "calendar", title: "Smart Scheduling", description: "Manage appointments effortlessly")
                    .tag(1)
                OnboardingPage(icon: "chart.line.uptrend.xyaxis", title: "Business Insights", description: "Track your success with real-time analytics")
                    .tag(2)
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(action: onComplete) {
                Text(currentPage == 2 ? "Get Started" : "Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding()
        }
    }
}

struct OnboardingPage: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 80))
                .foregroundColor(.blue)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
        }
    }
}
