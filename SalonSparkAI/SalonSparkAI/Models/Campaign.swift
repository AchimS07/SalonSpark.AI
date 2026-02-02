//
//  Campaign.swift
//  SalonSparkAI
//
//  Marketing campaign model
//

import Foundation

enum CampaignType: String, Codable, CaseIterable {
    case social = "Social Media"
    case email = "Email"
    case sms = "SMS"
    case offer = "Special Offer"
}

struct Campaign: Identifiable, Codable {
    let id: String
    var title: String
    var description: String
    var type: CampaignType
    var content: String
    var targetAudience: String
    var startDate: Date
    var endDate: Date?
    var status: CampaignStatus
    var impressions: Int
    var clicks: Int
    var conversions: Int
    var createdAt: Date
    
    init(id: String = UUID().uuidString,
         title: String,
         description: String,
         type: CampaignType,
         content: String,
         targetAudience: String,
         startDate: Date,
         endDate: Date? = nil,
         status: CampaignStatus = .draft,
         impressions: Int = 0,
         clicks: Int = 0,
         conversions: Int = 0,
         createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.content = content
        self.targetAudience = targetAudience
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.impressions = impressions
        self.clicks = clicks
        self.conversions = conversions
        self.createdAt = createdAt
    }
    
    var clickRate: Double {
        guard impressions > 0 else { return 0 }
        return Double(clicks) / Double(impressions)
    }
    
    var conversionRate: Double {
        guard clicks > 0 else { return 0 }
        return Double(conversions) / Double(clicks)
    }
}

enum CampaignStatus: String, Codable, CaseIterable {
    case draft = "Draft"
    case scheduled = "Scheduled"
    case active = "Active"
    case completed = "Completed"
    case paused = "Paused"
}
