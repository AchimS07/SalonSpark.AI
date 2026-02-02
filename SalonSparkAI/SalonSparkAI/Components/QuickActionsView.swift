//
//  QuickActionsView.swift
//  SalonSparkAI
//
//  Quick action buttons grid
//

import SwiftUI

struct QuickActionsView: View {
    let actions: [QuickAction]
    let onAction: (String) -> Void
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
            ForEach(actions) { action in
                Button(action: {
                    onAction(action.id)
                }) {
                    VStack(spacing: 8) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(action.color)
                                .frame(width: 48, height: 48)
                            
                            Image(systemName: action.icon)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.white)
                        }
                        
                        Text(action.label)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.cardBackground)
                    .cornerRadius(16)
                    .shadow(color: Color.cardShadow, radius: 6, x: 0, y: 2)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }
}

// MARK: - Scale Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    QuickActionsView(
        actions: QuickAction.defaultActions,
        onAction: { _ in }
    )
    .padding()
}
