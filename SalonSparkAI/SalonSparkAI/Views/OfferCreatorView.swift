//
//  OfferCreatorView.swift
//  SalonSparkAI - Offer Generator
//

import SwiftUI

struct OfferCreatorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var selectedTime = "2:00 PM"
    @State private var duration = "1 hour"
    @State private var generatedOffer: SlotPromotion?
    @State private var isGenerating = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Empty Slot Time")
                            .font(.headline)
                        TextField("Time", text: $selectedTime)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Duration")
                            .font(.headline)
                        TextField("Duration", text: $duration)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    Button(action: generateOffer) {
                        HStack {
                            if isGenerating {
                                ProgressView().tint(.white)
                            } else {
                                Image(systemName: "sparkles")
                                Text("Generate Offer")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isGenerating)
                    
                    if let offer = generatedOffer {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("\(offer.discount)% OFF")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                                Spacer()
                            }
                            
                            Text(offer.title)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text(offer.description)
                                .font(.body)
                            
                            Divider()
                            
                            HStack {
                                Text("Valid until:")
                                    .foregroundColor(.secondary)
                                Text(offer.validUntil.shortDateString)
                                    .fontWeight(.semibold)
                            }
                            
                            Button(action: shareOffer) {
                                Label("Share Offer", systemImage: "square.and.arrow.up")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.green, lineWidth: 2)
                        )
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Offer Generator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func generateOffer() {
        isGenerating = true
        Task {
            let offer = await appState.aiService.generateSlotPromotion(
                time: selectedTime,
                duration: duration
            )
            await MainActor.run {
                generatedOffer = offer
                isGenerating = false
            }
        }
    }
    
    private func shareOffer() {
        guard let offer = generatedOffer else { return }
        let text = "\(offer.title)\n\n\(offer.description)\n\nValid until: \(offer.validUntil.shortDateString)"
        UIPasteboard.general.string = text
        appState.showSuccess("Offer copied! Ready to share.")
    }
}
