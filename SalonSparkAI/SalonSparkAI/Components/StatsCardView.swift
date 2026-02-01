//
//  StatsCardView.swift
//  SalonSparkAI
//
//  Stats card component for displaying key metrics
//

import SwiftUI

struct StatsCardView: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    var trend: Int? = nil
    var isPositive: Bool = true
    var isPrimary: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundColor(isPrimary ? .white : .blue)
                
                Spacer()
                
                if let trend = trend {
                    HStack(spacing: 4) {
                        Image(systemName: isPositive ? "arrow.up" : "arrow.down")
                            .font(.caption)
                        Text("\(trend)%")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(isPositive ? .green : .red)
                }
            }
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(isPrimary ? .white : .primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(isPrimary ? .white.opacity(0.9) : .secondary)
            
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(isPrimary ? .white.opacity(0.7) : .secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isPrimary ? LinearGradient(
                    colors: [Color.blue, Color.blue.opacity(0.8)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ) : LinearGradient(
                    colors: [Color(UIColor.systemBackground)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
    }
}

#Preview {
    VStack {
        StatsCardView(
            title: "Today's Bookings",
            value: "8",
            subtitle: "3 remaining",
            icon: "calendar",
            trend: 12,
            isPositive: true
        )
        
        StatsCardView(
            title: "Revenue",
            value: "$485",
            subtitle: "Today's total",
            icon: "dollarsign.circle.fill",
            isPrimary: true
        )
    }
    .padding()
}
