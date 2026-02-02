//
//  AIPostGeneratorView.swift
//  SalonSparkAI - AI Post Generator
//

import SwiftUI

struct AIPostGeneratorView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    @State private var selectedService = "Haircut"
    @State private var selectedStyle = PostStyle.promotional
    @State private var selectedPlatform = SocialPlatform.instagram
    @State private var generatedPost: SocialPost?
    @State private var isGenerating = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Input Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Service")
                            .font(.headline)
                        Picker("Service", selection: $selectedService) {
                            ForEach(appState.services, id: \.name) { service in
                                Text(service.name).tag(service.name)
                            }
                        }
                        .pickerStyle(.menu)
                        
                        Text("Style")
                            .font(.headline)
                        Picker("Style", selection: $selectedStyle) {
                            ForEach(PostStyle.allCases, id: \.self) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Text("Platform")
                            .font(.headline)
                        Picker("Platform", selection: $selectedPlatform) {
                            ForEach(SocialPlatform.allCases, id: \.self) { platform in
                                Text(platform.rawValue).tag(platform)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    
                    // Generate Button
                    Button(action: generatePost) {
                        HStack {
                            if isGenerating {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .tint(.white)
                            } else {
                                Image(systemName: "sparkles")
                                Text("Generate Post")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .disabled(isGenerating)
                    
                    // Generated Post
                    if let post = generatedPost {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Generated Post")
                                .font(.headline)
                            
                            Text(post.fullText)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.tertiarySystemBackground))
                                .cornerRadius(8)
                            
                            Text("Image Suggestion:")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text(post.imagePrompt)
                                .font(.caption)
                                .italic()
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.yellow.opacity(0.1))
                                .cornerRadius(8)
                            
                            HStack {
                                Button(action: copyToClipboard) {
                                    Label("Copy", systemImage: "doc.on.doc")
                                }
                                .buttonStyle(.bordered)
                                
                                Button(action: regenerate) {
                                    Label("Regenerate", systemImage: "arrow.clockwise")
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("AI Post Generator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    private func generatePost() {
        isGenerating = true
        Task {
            let post = await appState.aiService.generateSocialPost(
                for: selectedService,
                style: selectedStyle,
                platform: selectedPlatform
            )
            await MainActor.run {
                generatedPost = post
                isGenerating = false
            }
        }
    }
    
    private func regenerate() {
        generatedPost = nil
        generatePost()
    }
    
    private func copyToClipboard() {
        if let post = generatedPost {
            UIPasteboard.general.string = post.fullText
            appState.showSuccess("Copied to clipboard!")
        }
    }
}
