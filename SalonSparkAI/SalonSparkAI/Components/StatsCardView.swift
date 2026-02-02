//
//  StatsCardView.swift
//  SalonSparkAI
//
//  Stats card component with gradient and trend indicators
//

import SwiftUI

struct StatsCardView: View {
    let title: String
    let value: String
    let subtitle: String?
    let icon: String
    var trend: (value: Int, isPositive: Bool)?
    var variant: CardVariant = .default
    
    enum CardVariant {
        case `default`
        case primary
        case accent
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconBackground)
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(iconColor)
                }
                
                Spacer()
                
                // Trend indicator
                if let trend = trend {
                    HStack(spacing: 4) {
                        Image(systemName: trend.isPositive ? "arrow.up" : "arrow.down")
                            .font(.system(size: 10, weight: .bold))
                        Text("\(trend.value)%")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .foregroundColor(trend.isPositive ? .green : .red)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(trend.isPositive ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    )
                }
            }
            
            Spacer()
            
            // Title
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(textSecondaryColor)
            
            // Value
            Text(value)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(textPrimaryColor)
            
            // Subtitle
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.system(size: 11))
                    .foregroundColor(textSecondaryColor)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 140)
        .background(cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Computed Properties
    private var cardBackground: some View {
        Group {
            switch variant {
            case .default:
                Color.cardBackground
            case .primary:
                LinearGradient.roseGradient
            case .accent:
                Color.purple.opacity(0.1)
            }
        }
    }
    
    private var iconBackground: Color {
        switch variant {
        case .default, .accent:
            return Color.blue.opacity(0.1)
        case .primary:
            return Color.white.opacity(0.2)
        }
    }
    
    private var iconColor: Color {
        switch variant {
        case .default, .accent:
            return .blue
        case .primary:
            return .white
        }
    }
    
    private var textPrimaryColor: Color {
        variant == .primary ? .white : .primary
    }
    
    private var textSecondaryColor: Color {
        variant == .primary ? .white.opacity(0.8) : .secondary
    }
}

#Preview {
    VStack(spacing: 16) {
        HStack(spacing: 12) {
            StatsCardView(
                title: "Today's Bookings",
                value: "8",
                subtitle: "3 remaining",
                icon: "calendar",
                trend: (value: 12, isPositive: true)
            )
            
            StatsCardView(
                title: "Revenue",
                value: "$485",
                subtitle: "Today's total",
                icon: "dollarsign.circle.fill",
                variant: .primary
            )
        }
        
        HStack(spacing: 12) {
            StatsCardView(
                title: "New Clients",
                value: "12",
                subtitle: "This week",
                icon: "person.2.fill",
                trend: (value: 8, isPositive: true)
            )
            
            StatsCardView(
                title: "Fill Rate",
                value: "76%",
                subtitle: "This month",
                icon: "chart.bar.fill"
            )
        }
    }
    .padding()
}

