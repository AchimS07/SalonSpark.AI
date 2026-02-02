//
//  OnboardingView.swift
//  SalonSparkAI
//
//  Onboarding flow with animations and feature showcase
//

import SwiftUI

struct OnboardingView: View {
    let onComplete: () -> Void
    @State private var currentStep = 0
    
    let features = [
        OnboardingFeature(
            icon: "sparkles",
            title: "AI-Powered Promotions",
            description: "Let AI create stunning social posts and targeted campaigns to fill your empty slots.",
            gradient: [Color.pink, Color.orange]
        ),
        OnboardingFeature(
            icon: "calendar",
            title: "Smart Scheduling",
            description: "Automatically optimize your calendar and reduce no-shows with intelligent reminders.",
            gradient: [Color.blue, Color.cyan]
        ),
        OnboardingFeature(
            icon: "person.2.fill",
            title: "Client Growth",
            description: "Build lasting relationships with personalized offers and loyalty programs.",
            gradient: [Color.purple, Color.pink]
        ),
        OnboardingFeature(
            icon: "chart.line.uptrend.xyaxis",
            title: "Business Insights",
            description: "Track performance and get actionable recommendations to grow your salon.",
            gradient: [Color.green, Color.mint]
        )
    ]
    
    var body: some View {
        ZStack {
            // Warm gradient background
            LinearGradient(
                colors: [
                    Color.orange.opacity(0.1),
                    Color.pink.opacity(0.1),
                    Color.purple.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Skip button
                HStack {
                    Spacer()
                    Button(action: onComplete) {
                        Text("Skip")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
                
                Spacer()
                
                // Feature content
                VStack(spacing: 32) {
                    // Animated icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(
                                LinearGradient(
                                    colors: features[currentStep].gradient,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 96, height: 96)
                            .shadow(color: features[currentStep].gradient[0].opacity(0.3), radius: 20, x: 0, y: 10)
                        
                        Image(systemName: features[currentStep].icon)
                            .font(.system(size: 48))
                            .foregroundColor(.white)
                    }
                    .floatingAnimation()
                    
                    // Title and description
                    VStack(spacing: 16) {
                        Text(features[currentStep].title)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                        
                        Text(features[currentStep].description)
                            .font(.system(size: 17))
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: currentStep)
                
                Spacer()
                
                // Progress and CTA
                VStack(spacing: 24) {
                    // Progress dots
                    HStack(spacing: 8) {
                        ForEach(0..<features.count, id: \.self) { index in
                            Button(action: {
                                withAnimation(.spring(response: 0.3)) {
                                    currentStep = index
                                }
                            }) {
                                Capsule()
                                    .fill(index == currentStep ? Color.blue : Color.gray.opacity(0.3))
                                    .frame(width: index == currentStep ? 32 : 8, height: 8)
                            }
                        }
                    }
                    
                    // CTA Button
                    Button(action: handleNext) {
                        HStack(spacing: 8) {
                            Text(currentStep < features.count - 1 ? "Continue" : "Get Started")
                                .font(.headline)
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [Color.pink, Color.orange],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    private func handleNext() {
        if currentStep < features.count - 1 {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                currentStep += 1
            }
        } else {
            onComplete()
        }
    }
}

struct OnboardingFeature {
    let icon: String
    let title: String
    let description: String
    let gradient: [Color]
}

#Preview {
    OnboardingView(onComplete: {})
}
