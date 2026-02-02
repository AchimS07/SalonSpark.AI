//
//  SalonSparkAIApp.swift
//  SalonSparkAI
//
//  Main app entry point
//

import SwiftUI

@main
struct SalonSparkAIApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
