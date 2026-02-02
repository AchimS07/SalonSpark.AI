//
//  CampaignCreatorView.swift
//  SalonSparkAI - Campaign Creator
//

import SwiftUI

struct CampaignCreatorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var campaignType = CampaignType.email
    @State private var targetAudience = "All Clients"
    @State private var offerText = "20% off all services"
    @State private var generatedContent: CampaignContent?
    @State private var isGenerating = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Campaign Type")
                            .font(.headline)
                        Picker("Type", selection: $campaignType) {
                            ForEach(CampaignType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Text("Target Audience")
                            .font(.headline)
                        TextField("e.g., VIP Clients, New Customers", text: $targetAudience)
                            .textFieldStyle(.roundedBorder)
                        
                        Text("Offer")
                            .font(.headline)
                        TextField("e.g., 20% off, Free consultation", text: $offerText)
                            .textFieldStyle(.roundedBorder)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    Button(action: generateCampaign) {
                        HStack {
                            if isGenerating {
                                ProgressView().tint(.white)
                            } else {
                                Image(systemName: "sparkles")
                                Text("Generate Campaign")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isGenerating)
                    
                    if let content = generatedContent {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Subject")
                                .font(.headline)
                            Text(content.subject)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.tertiarySystemBackground))
                                .cornerRadius(8)
                            
                            Text("Content")
                                .font(.headline)
                            Text(content.body)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.tertiarySystemBackground))
                                .cornerRadius(8)
                            
                            Button(action: saveCampaign) {
                                Label("Save Campaign", systemImage: "checkmark")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Campaign Creator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func generateCampaign() {
        isGenerating = true
        Task {
            let content = await appState.aiService.generateCampaign(
                type: campaignType,
                target: targetAudience,
                offer: offerText
            )
            await MainActor.run {
                generatedContent = content
                isGenerating = false
            }
        }
    }
    
    private func saveCampaign() {
        guard let content = generatedContent else { return }
        let campaign = Campaign(
            title: content.subject,
            description: offerText,
            type: campaignType,
            content: content.body,
            targetAudience: targetAudience,
            startDate: Date(),
            status: .draft
        )
        appState.addCampaign(campaign)
        dismiss()
    }
}
