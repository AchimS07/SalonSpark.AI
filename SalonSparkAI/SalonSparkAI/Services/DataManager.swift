//
//  DataManager.swift
//  SalonSparkAI
//
//  Data persistence manager
//

import Foundation

class DataManager {
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Save Data
    func saveAppointments(_ appointments: [Appointment]) {
        if let encoded = try? JSONEncoder().encode(appointments) {
            userDefaults.set(encoded, forKey: "appointments")
        }
    }
    
    func saveClients(_ clients: [Client]) {
        if let encoded = try? JSONEncoder().encode(clients) {
            userDefaults.set(encoded, forKey: "clients")
        }
    }
    
    func saveCampaigns(_ campaigns: [Campaign]) {
        if let encoded = try? JSONEncoder().encode(campaigns) {
            userDefaults.set(encoded, forKey: "campaigns")
        }
    }
    
    // MARK: - Load Data
    func loadAppointments() -> [Appointment] {
        guard let data = userDefaults.data(forKey: "appointments"),
              let appointments = try? JSONDecoder().decode([Appointment].self, from: data) else {
            return []
        }
        return appointments
    }
    
    func loadClients() -> [Client] {
        guard let data = userDefaults.data(forKey: "clients"),
              let clients = try? JSONDecoder().decode([Client].self, from: data) else {
            return []
        }
        return clients
    }
    
    func loadCampaigns() -> [Campaign] {
        guard let data = userDefaults.data(forKey: "campaigns"),
              let campaigns = try? JSONDecoder().decode([Campaign].self, from: data) else {
            return []
        }
        return campaigns
    }
    
    // MARK: - Export
    func exportToCSV(appointments: [Appointment]) -> String {
        var csv = "Date,Time,Client,Service,Duration,Status\n"
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        for apt in appointments {
            csv += "\(formatter.string(from: apt.date)),\(apt.clientName),\(apt.serviceName),\(apt.duration),\(apt.status.rawValue)\n"
        }
        
        return csv
    }
}
