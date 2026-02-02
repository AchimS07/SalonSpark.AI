//
//  AIInsightsView.swift
//  SalonSparkAI
//
//  AI-generated insights display
//

import SwiftUI

struct AIInsightsView: View {
    let insights: [AIInsight]
    let onAction: (String) -> Void
    let onViewAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(LinearGradient.roseGradient)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: "sparkles")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("AI Suggestions")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Text("Personalized for your salon")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            
            // Insights list
            VStack(spacing: 12) {
                ForEach(Array(insights.prefix(3).enumerated()), id: \.element.id) { index, insight in
                    insightRow(insight, index: index)
                }
            }
            
            // View all button
            if insights.count > 3 {
                Button(action: onViewAll) {
                    Text("View All Suggestions")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(20)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Insight Row
    private func insightRow(_ insight: AIInsight, index: Int) -> some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(insightColor(for: insight.type).opacity(0.1))
                    .frame(width: 32, height: 32)
                
                Image(systemName: insight.type.iconName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(insightColor(for: insight.type))
            }
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(insight.title)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                
                Text(insight.description)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text(insight.impact)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.green)
                    
                    Spacer()
                    
                    Button(action: {
                        onAction(insight.id)
                    }) {
                        Text(insight.action)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.clear,
                            insightColor(for: insight.type).opacity(0.05)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.gray.opacity(0.1), lineWidth: 1)
                )
        )
        .fadeUpAnimation(delay: Double(index) * 0.1)
    }
    
    // MARK: - Helper
    private func insightColor(for type: InsightType) -> Color {
        switch type {
        case .promotion: return .orange
        case .content: return .blue
        case .timing: return .purple
        case .offer: return .pink
        }
    }
}

#Preview {
    AIInsightsView(
        insights: AIInsight.mockInsights,
        onAction: { _ in },
        onViewAll: {}
    )
    .padding()
}
