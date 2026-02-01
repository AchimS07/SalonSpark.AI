//
//  AIInsight.swift
//  SalonSparkAI
//
//  Model for AI-generated insights
//

import Foundation

enum InsightType: String {
    case promotion
    case content
    case timing
}

struct AIInsight: Identifiable {
    let id: String
    let type: InsightType
    let title: String
    let description: String
    let action: String
    let impact: String
}

// Mock data
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
        )
    ]
}
