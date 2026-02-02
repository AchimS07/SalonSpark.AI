//
//  HeaderView.swift
//  SalonSparkAI
//
//  Dashboard header with search and notifications
//

import SwiftUI

struct HeaderView: View {
    let salonName: String
    let notificationCount: Int
    let onSearch: () -> Void
    let onNotifications: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 12) {
                // Salon info
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Welcome back")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("✨")
                            .font(.caption)
                    }
                    
                    Text(salonName)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                // Action buttons
                HStack(spacing: 8) {
                    // Search button
                    Button(action: onSearch) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                    
                    // Notifications button
                    Button(action: onNotifications) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.primary)
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                            
                            if notificationCount > 0 {
                                Text("\(min(notificationCount, 9))")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(width: 18, height: 18)
                                    .background(
                                        Circle()
                                            .fill(Color.blue)
                                    )
                                    .offset(x: 6, y: -6)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                Color(UIColor.systemBackground)
                    .opacity(0.8)
                    .background(.ultraThinMaterial)
            )
            
            Divider()
                .opacity(0.5)
        }
    }
}

#Preview {
    HeaderView(
        salonName: "Luxe Beauty Studio",
        notificationCount: 3,
        onSearch: {},
        onNotifications: {}
    )
}
