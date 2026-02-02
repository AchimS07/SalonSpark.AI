//
//  AIInsight.swift
//  SalonSparkAI
//
//  AI-generated insight model
//

import Foundation

enum InsightType: String, Codable {
    case promotion
    case content
    case timing
    case offer
    
    var iconName: String {
        switch self {
        case .promotion: return "megaphone.fill"
        case .content: return "message.fill"
        case .timing: return "chart.line.uptrend.xyaxis"
        case .offer: return "sparkles"
        }
    }
}

struct AIInsight: Identifiable, Codable {
    let id: String
    let type: InsightType
    let title: String
    let description: String
    let action: String
    let impact: String
    
    init(id: String, type: InsightType, title: String, description: String, action: String, impact: String) {
        self.id = id
        self.type = type
        self.title = title
        self.description = description
        self.action = action
        self.impact = impact
    }
}

// MARK: - Mock Data
extension AIInsight {
    static let mockInsights = [
        AIInsight(
            id: "1",
            type: .promotion,
            title: "Flash Sale Opportunity",
            description: "Your 2PM slot has been empty for 3 days. A 20% discount could attract new clients.",
            action: "Create Offer",
            impact: "+15% booking rate"
        ),
        AIInsight(
            id: "2",
            type: .content,
            title: "Post Trending Content",
            description: "Balayage tutorials are trending. Post your recent work to boost visibility.",
            action: "Generate Post",
            impact: "+200 reach"
        ),
        AIInsight(
            id: "3",
            type: .timing,
            title: "Best Posting Time",
            description: "Your audience is most active at 7PM today. Schedule your post then.",
            action: "Schedule",
            impact: "+35% engagement"
        ),
        AIInsight(
            id: "4",
            type: .offer,
            title: "Loyalty Reward",
            description: "5 clients are close to their 5th visit. Send them a special offer to encourage rebooking.",
            action: "Send Offer",
            impact: "+3 bookings"
        )
    ]
}
