//
//  EmptySlotsView.swift
//  SalonSparkAI
//
//  Empty slots display with promotion actions
//

import SwiftUI

struct EmptySlotsView: View {
    let slots: [EmptySlot]
    let onPromote: (String) -> Void
    let onPromoteAll: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if slots.isEmpty {
                emptyState
            } else {
                slotsContent
            }
        }
        .padding(20)
        .background(Color.cardBackground)
        .cornerRadius(16)
        .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 2)
    }
    
    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 64, height: 64)
                
                Image(systemName: "calendar.badge.checkmark")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.blue)
            }
            
            VStack(spacing: 8) {
                Text("All Booked!")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                
                Text("Amazing! You have no empty slots today.")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }
    
    // MARK: - Slots Content
    private var slotsContent: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Empty Slots Today")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Text("\(slots.count) slots available")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: onPromoteAll) {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 12, weight: .semibold))
                        Text("AI Promote All")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        LinearGradient.roseGradient
                    )
                    .cornerRadius(10)
                }
                .buttonStyle(ScaleButtonStyle())
            }
            
            // Slots list
            VStack(spacing: 12) {
                ForEach(Array(slots.enumerated()), id: \.element.id) { index, slot in
                    slotRow(slot, index: index)
                }
            }
        }
    }
    
    // MARK: - Slot Row
    private func slotRow(_ slot: EmptySlot, index: Int) -> some View {
        HStack(spacing: 12) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: "clock.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.blue)
            }
            
            // Time info
            VStack(alignment: .leading, spacing: 2) {
                Text(slot.time)
                    .font(.system(size: 15, weight: .semibold))
                
                Text(slot.duration)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Promote button
            Button(action: {
                onPromote(slot.id)
            }) {
                Text("Promote")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.blue, lineWidth: 1.5)
                    )
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.gray.opacity(0.1), lineWidth: 1)
                )
        )
        .fadeUpAnimation(delay: Double(index) * 0.1)
    }
}

#Preview {
    VStack(spacing: 20) {
        EmptySlotsView(
            slots: EmptySlot.mockEmptySlots,
            onPromote: { _ in },
            onPromoteAll: {}
        )
        
        EmptySlotsView(
            slots: [],
            onPromote: { _ in },
            onPromoteAll: {}
        )
    }
    .padding()
}
