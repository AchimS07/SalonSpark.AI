//
//  ViewExtensions.swift
//  SalonSparkAI
//
//  Reusable view modifiers and animations
//

import SwiftUI

// MARK: - Card Style Modifier
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.cardBackground)
            .cornerRadius(16)
            .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 2)
    }
}

// MARK: - Soft Shadow Modifier
struct SoftShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.1), radius: 12, x: 0, y: 4)
    }
}

// MARK: - Floating Animation
struct FloatingAnimation: ViewModifier {
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        content
            .offset(y: isAnimating ? -10 : 0)
            .animation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

// MARK: - Fade Up Animation
struct FadeUpAnimation: ViewModifier {
    @State private var isVisible = false
    let delay: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 20)
            .onAppear {
                withAnimation(.easeOut(duration: 0.5).delay(delay)) {
                    isVisible = true
                }
            }
    }
}

// MARK: - Shimmer Effect
struct ShimmerEffect: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [
                        Color.white.opacity(0),
                        Color.white.opacity(0.3),
                        Color.white.opacity(0)
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .rotationEffect(.degrees(30))
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 300
                }
            }
    }
}

// MARK: - View Extension
extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
    
    func softShadow() -> some View {
        modifier(SoftShadow())
    }
    
    func floatingAnimation() -> some View {
        modifier(FloatingAnimation())
    }
    
    func fadeUpAnimation(delay: Double = 0) -> some View {
        modifier(FadeUpAnimation(delay: delay))
    }
    
    func shimmerEffect() -> some View {
        modifier(ShimmerEffect())
    }
}

// MARK: - Haptic Feedback
extension View {
    func hapticFeedback(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        self.simultaneousGesture(
            TapGesture().onEnded { _ in
                let generator = UIImpactFeedbackGenerator(style: style)
                generator.impactOccurred()
            }
        )
    }
}
