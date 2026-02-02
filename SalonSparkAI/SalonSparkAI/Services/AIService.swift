//
//  AIService.swift
//  SalonSparkAI
//
//  AI-powered content generation service
//

import Foundation

class AIService {
    
    // MARK: - Social Media Post Generation
    func generateSocialPost(for service: String, style: PostStyle, platform: SocialPlatform) async -> SocialPost {
        // Simulate AI processing delay
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        let posts = getPostTemplates(service: service, style: style, platform: platform)
        let randomPost = posts.randomElement() ?? posts[0]
        
        return SocialPost(
            content: randomPost.content,
            hashtags: randomPost.hashtags,
            platform: platform,
            imagePrompt: randomPost.imagePrompt
        )
    }
    
    private func getPostTemplates(service: String, style: PostStyle, platform: SocialPlatform) -> [SocialPost] {
        switch style {
        case .promotional:
            return [
                SocialPost(
                    content: "✨ Transform your look with our amazing \(service)! Book now and get 20% off your first visit. Limited time offer! 💇‍♀️",
                    hashtags: ["#SalonLife", "#HairGoals", "#BeautyDeals", "#\(service.replacingOccurrences(of: " ", with: ""))"],
                    platform: platform,
                    imagePrompt: "Beautiful salon interior with stylist working on client's \(service.lowercased())"
                ),
                SocialPost(
                    content: "🌟 Special Alert! Get gorgeous \(service) at an unbeatable price. Your dream hair is just one appointment away! ✂️",
                    hashtags: ["#SalonSpecial", "#HairTransformation", "#BeautyOffer", "#Haircare"],
                    platform: platform,
                    imagePrompt: "Before and after \(service.lowercased()) transformation"
                )
            ]
            
        case .educational:
            return [
                SocialPost(
                    content: "💡 Did you know? Regular \(service) can significantly improve hair health and appearance. Here's what you need to know about maintaining gorgeous locks! 📚",
                    hashtags: ["#HairCare", "#BeautyTips", "#SalonEducation", "#HealthyHair"],
                    platform: platform,
                    imagePrompt: "Educational infographic about \(service.lowercased()) benefits"
                ),
                SocialPost(
                    content: "🎓 Hair Care 101: Everything you need to know about \(service). Swipe to learn the secrets to maintaining salon-perfect hair! 💫",
                    hashtags: ["#HairTips", "#BeautyEducation", "#SalonSecrets", "#HairHealth"],
                    platform: platform,
                    imagePrompt: "Step-by-step guide for \(service.lowercased())"
                )
            ]
            
        case .inspirational:
            return [
                SocialPost(
                    content: "💖 Your hair is your crown. Treat yourself to our luxurious \(service) and feel absolutely radiant! You deserve this moment of self-care. ✨",
                    hashtags: ["#SelfCare", "#BeautyInspiration", "#HairLove", "#YouDeserveThis"],
                    platform: platform,
                    imagePrompt: "Confident woman with beautiful \(service.lowercased()) result"
                ),
                SocialPost(
                    content: "🌺 Beautiful hair, beautiful you! Our \(service) is designed to bring out your natural confidence and inner beauty. Embrace your gorgeous self! 💕",
                    hashtags: ["#Confidence", "#BeautyGoals", "#InnerBeauty", "#HairInspiration"],
                    platform: platform,
                    imagePrompt: "Inspiring portrait showcasing \(service.lowercased())"
                )
            ]
            
        case .storytelling:
            return [
                SocialPost(
                    content: "✨ Meet Sarah! She came to us wanting a change. After our signature \(service), she left feeling like a whole new person. This is why we love what we do! 💕",
                    hashtags: ["#TransformationTuesday", "#ClientStory", "#SalonMagic", "#BeforeAndAfter"],
                    platform: platform,
                    imagePrompt: "Client testimonial photo for \(service.lowercased())"
                ),
                SocialPost(
                    content: "🎭 Every client has a story. Today's transformation: From stressed to blessed with our rejuvenating \(service). Watch the magic happen! ✂️",
                    hashtags: ["#ClientJourney", "#HairStory", "#SalonExperience", "#Transformation"],
                    platform: platform,
                    imagePrompt: "Behind-the-scenes of \(service.lowercased()) process"
                )
            ]
        }
    }
    
    // MARK: - Campaign Generation
    func generateCampaign(type: CampaignType, target: String, offer: String) async -> CampaignContent {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        switch type {
        case .email:
            return CampaignContent(
                subject: "🌟 Exclusive Offer Just For You: \(offer)",
                body: """
                Hi there!
                
                We've noticed you love taking care of your hair, and we have something special just for you!
                
                ✨ \(offer) ✨
                
                Target: \(target)
                
                This exclusive offer is our way of saying thank you for being an amazing client. Book your appointment today and experience the luxury you deserve.
                
                Why choose us:
                • Expert stylists with 10+ years experience
                • Premium products that care for your hair
                • Relaxing spa-like atmosphere
                • Personalized service every time
                
                Ready to treat yourself? Click below to book now!
                
                [BOOK APPOINTMENT]
                
                This offer is valid for a limited time only. Don't miss out!
                
                With love,
                Your Salon Team 💕
                """,
                cta: "Book Your Appointment"
            )
            
        case .sms:
            return CampaignContent(
                subject: "SMS Campaign",
                body: "🌟 Hey! Special offer for you: \(offer). Book now: [LINK]. Reply STOP to opt out.",
                cta: "Book Now"
            )
            
        case .social:
            return CampaignContent(
                subject: "Social Media Campaign",
                body: "🎉 SPECIAL OFFER ALERT! 🎉\n\n\(offer)\n\nPerfect for: \(target)\n\nTag a friend who needs this! 💕\nBook now - link in bio!\n\n#SalonSpecial #BeautyDeals #HairGoals",
                cta: "Link in Bio"
            )
            
        case .offer:
            return CampaignContent(
                subject: "Limited Time Offer",
                body: "🎁 \(offer)\n\nIdeal for: \(target)\n\nTerms: Valid for new bookings only. Cannot be combined with other offers. Expires in 30 days.",
                cta: "Claim Offer"
            )
        }
    }
    
    // MARK: - Slot Promotion
    func generateSlotPromotion(time: String, duration: String) async -> SlotPromotion {
        try? await Task.sleep(nanoseconds: 800_000_000)
        
        let promotions = [
            SlotPromotion(
                title: "Flash Sale: \(time) Slot Available! ⚡",
                description: "Book our \(time) appointment (\(duration)) and get 25% off any service!",
                discount: 25,
                validUntil: Calendar.current.date(byAdding: .day, value: 3, to: Date())!
            ),
            SlotPromotion(
                title: "Last Minute Deal: \(time) 🎉",
                description: "Grab our \(time) slot (\(duration)) with a special 20% discount. First come, first served!",
                discount: 20,
                validUntil: Calendar.current.date(byAdding: .day, value: 2, to: Date())!
            ),
            SlotPromotion(
                title: "Prime Time Offer: \(time) Available ✨",
                description: "Perfect timing! Book \(time) (\(duration)) today and save 30%!",
                discount: 30,
                validUntil: Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            )
        ]
        
        return promotions.randomElement()!
    }
    
    // MARK: - Business Insights
    func generateInsights(appointments: [Appointment], revenue: Double) async -> [AIInsight] {
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        return [
            AIInsight(
                title: "Peak Hours Optimization",
                description: "Your busiest hours are 2-4 PM. Consider offering early bird discounts for 9-11 AM slots to balance the schedule.",
                impact: "+$350/week potential",
                action: "Create Morning Special",
                priority: .high
            ),
            AIInsight(
                title: "Service Bundle Opportunity",
                description: "Clients who book Color also book Blowout 80% of the time. Create a combo package!",
                impact: "+15% revenue",
                action: "Build Package",
                priority: .medium
            ),
            AIInsight(
                title: "Client Retention Alert",
                description: "5 VIP clients haven't booked in 30+ days. Send personalized offers to re-engage them.",
                impact: "+3 bookings",
                action: "Send Offers",
                priority: .high
            ),
            AIInsight(
                title: "Social Media Timing",
                description: "Your posts at 7 PM get 2x more engagement. Schedule your next campaign for this time.",
                impact: "+40% reach",
                action: "Schedule Post",
                priority: .low
            )
        ]
    }
}

// MARK: - Supporting Types

enum PostStyle: String, CaseIterable {
    case promotional = "Promotional"
    case educational = "Educational"
    case inspirational = "Inspirational"
    case storytelling = "Storytelling"
}

enum SocialPlatform: String, CaseIterable {
    case instagram = "Instagram"
    case facebook = "Facebook"
    case twitter = "Twitter"
    case tiktok = "TikTok"
}

struct SocialPost {
    let content: String
    let hashtags: [String]
    let platform: SocialPlatform
    let imagePrompt: String
    
    var fullText: String {
        content + "\n\n" + hashtags.map { "#\($0)" }.joined(separator: " ")
    }
}

struct CampaignContent {
    let subject: String
    let body: String
    let cta: String
}

struct SlotPromotion {
    let title: String
    let description: String
    let discount: Int
    let validUntil: Date
}

struct AIInsight {
    let title: String
    let description: String
    let impact: String
    let action: String
    let priority: InsightPriority
}

enum InsightPriority {
    case high, medium, low
    
    var color: String {
        switch self {
        case .high: return "red"
        case .medium: return "orange"
        case .low: return "blue"
        }
    }
}
