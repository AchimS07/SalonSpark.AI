//
//  ColorExtensions.swift
//  SalonSparkAI
//
//  Custom colors matching the web app theme
//

import SwiftUI

extension Color {
    // Primary gradient colors
    static let gradientRose = LinearGradient(
        colors: [Color.pink, Color.orange],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let gradientWarm = LinearGradient(
        colors: [
            Color.orange.opacity(0.1),
            Color.pink.opacity(0.1)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Custom semantic colors
    static let cardBackground = Color(UIColor.systemBackground)
    static let cardShadow = Color.black.opacity(0.05)
    static let borderColor = Color.gray.opacity(0.2)
    
    // Action colors
    static let amberAction = Color.orange
    static let emeraldAction = Color.green
    static let pinkAction = Color.pink
}

extension LinearGradient {
    static let roseGradient = LinearGradient(
        colors: [Color.pink, Color.orange],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let warmBackground = LinearGradient(
        colors: [
            Color.orange.opacity(0.08),
            Color.pink.opacity(0.08),
            Color.purple.opacity(0.05)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
