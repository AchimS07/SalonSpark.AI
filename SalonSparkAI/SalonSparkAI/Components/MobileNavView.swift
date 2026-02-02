//
//  MobileNavView.swift
//  SalonSparkAI
//
//  Bottom navigation bar
//

import SwiftUI

struct MobileNavView: View {
    @Binding var activeTab: String
    let onTabChange: (String) -> Void
    
    let navItems = [
        NavItem(id: "home", icon: "house.fill", label: "Home"),
        NavItem(id: "calendar", icon: "calendar", label: "Schedule"),
        NavItem(id: "ai", icon: "sparkles", label: "AI Boost"),
        NavItem(id: "clients", icon: "person.2.fill", label: "Clients"),
        NavItem(id: "settings", icon: "gearshape.fill", label: "Settings")
    ]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(navItems) { item in
                Button(action: {
                    onTabChange(item.id)
                }) {
                    VStack(spacing: 4) {
                        ZStack {
                            Image(systemName: item.icon)
                                .font(.system(size: 20, weight: activeTab == item.id ? .semibold : .regular))
                                .foregroundColor(activeTab == item.id ? .blue : .secondary)
                                .scaleEffect(activeTab == item.id ? 1.1 : 1.0)
                            
                            // AI boost indicator
                            if item.id == "ai" && activeTab != "ai" {
                                Circle()
                                    .fill(Color.blue)
                                    .frame(width: 8, height: 8)
                                    .offset(x: 10, y: -10)
                                    .opacity(0.8)
                            }
                        }
                        
                        Text(item.label)
                            .font(.system(size: 10, weight: activeTab == item.id ? .semibold : .medium))
                            .foregroundColor(activeTab == item.id ? .blue : .secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(
                        activeTab == item.id ?
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.1))
                            .padding(.horizontal, 8)
                        : nil
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .animation(.spring(response: 0.3), value: activeTab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(
            Color(UIColor.systemBackground)
                .opacity(0.95)
                .background(.ultraThinMaterial)
                .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: -5)
        )
        .overlay(
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5),
            alignment: .top
        )
    }
}

struct NavItem: Identifiable {
    let id: String
    let icon: String
    let label: String
}

#Preview {
    VStack {
        Spacer()
        MobileNavView(
            activeTab: .constant("home"),
            onTabChange: { _ in }
        )
    }
}
