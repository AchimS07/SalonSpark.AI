//
//  ClientsViewModel.swift
//  SalonSparkAI
//
//  Client management view model
//

import SwiftUI
import Combine

class ClientsViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedFilter: ClientFilter = .all
    @Published var showAddClient = false
    @Published var selectedClient: Client?
    
    func filteredClients(_ clients: [Client]) -> [Client] {
        var filtered = clients
        
        // Apply search
        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.email.localizedCaseInsensitiveContains(searchText) ||
                $0.phone.contains(searchText)
            }
        }
        
        // Apply filter
        switch selectedFilter {
        case .all:
            break
        case .vip:
            filtered = filtered.filter { $0.isVIP }
        case .new:
            let thirtyDaysAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
            filtered = filtered.filter { $0.createdAt > thirtyDaysAgo }
        case .inactive:
            let sixtyDaysAgo = Calendar.current.date(byAdding: .day, value: -60, to: Date())!
            filtered = filtered.filter {
                if let lastVisit = $0.lastVisit {
                    return lastVisit < sixtyDaysAgo
                }
                return true
            }
        }
        
        // Sort by name
        return filtered.sorted { $0.name < $1.name }
    }
}

enum ClientFilter: String, CaseIterable {
    case all = "All"
    case vip = "VIP"
    case new = "New"
    case inactive = "Inactive"
}
