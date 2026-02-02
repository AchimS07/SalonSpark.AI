//
//  AIBoostView.swift
//  SalonSparkAI - AI Features Hub
//

import SwiftUI

struct AIBoostView: View {
    @EnvironmentObject var appState: AppState
    @State private var showPostGenerator = false
    @State private var showCampaignCreator = false
    @State private var showOfferCreator = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // AI Post Generator
                    AIFeatureCard(
                        icon: "photo.fill",
                        title: "AI Post Generator",
                        description: "Create engaging social media posts in seconds",
                        color: .pink
                    ) {
                        showPostGenerator = true
                    }
                    
                    // Campaign Creator
                    AIFeatureCard(
                        icon: "megaphone.fill",
                        title: "Campaign Creator",
                        description: "Design targeted marketing campaigns with AI",
                        color: .orange
                    ) {
                        showCampaignCreator = true
                    }
                    
                    // Offer Generator
                    AIFeatureCard(
                        icon: "gift.fill",
                        title: "Offer Generator",
                        description: "Create compelling offers for empty slots",
                        color: .green
                    ) {
                        showOfferCreator = true
                    }
                    
                    // Insights
                    AIInsightsCard()
                }
                .padding()
            }
            .navigationTitle("AI Boost")
            .sheet(isPresented: $showPostGenerator) {
                AIPostGeneratorView()
            }
            .sheet(isPresented: $showCampaignCreator) {
                CampaignCreatorView()
            }
            .sheet(isPresented: $showOfferCreator) {
                OfferCreatorView()
            }
        }
    }
}

struct AIFeatureCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .frame(width: 70, height: 70)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(16)
        }
    }
}

struct AIInsightsCard: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "sparkles")
                    .foregroundColor(.purple)
                Text("Today's Insights")
                    .font(.headline)
            }
            
            Text("🎯 Your 2PM slot has been empty for 3 days")
                .font(.subheadline)
            Text("💡 Recommendation: Create a 25% flash sale")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button("Generate Offer") {
                // Will trigger offer creator
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.purple.opacity(0.1))
        .cornerRadius(16)
    }
}
