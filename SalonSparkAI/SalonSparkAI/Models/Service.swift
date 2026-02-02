//
//  Service.swift
//  SalonSparkAI
//
//  Service/treatment model
//

import Foundation

struct Service: Identifiable, Codable {
    let id: String
    var name: String
    var description: String
    var duration: Int // in minutes
    var price: Double
    var category: ServiceCategory
    var isActive: Bool
    
    init(id: String = UUID().uuidString,
         name: String,
         description: String,
         duration: Int,
         price: Double,
         category: ServiceCategory,
         isActive: Bool = true) {
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.price = price
        self.category = category
        self.isActive = isActive
    }
    
    var formattedPrice: String {
        String(format: "$%.2f", price)
    }
    
    var durationString: String {
        if duration < 60 {
            return "\(duration) min"
        } else {
            let hours = duration / 60
            let mins = duration % 60
            if mins == 0 {
                return "\(hours)h"
            } else {
                return "\(hours)h \(mins)m"
            }
        }
    }
    
    static let sampleServices = [
        Service(
            name: "Women's Haircut",
            description: "Precision cut and style",
            duration: 60,
            price: 75.00,
            category: .cut
        ),
        Service(
            name: "Men's Haircut",
            description: "Classic or modern cut",
            duration: 45,
            price: 45.00,
            category: .cut
        ),
        Service(
            name: "Hair Color",
            description: "Full color application",
            duration: 120,
            price: 150.00,
            category: .color
        ),
        Service(
            name: "Balayage",
            description: "Hand-painted highlights",
            duration: 180,
            price: 250.00,
            category: .color
        ),
        Service(
            name: "Blowout",
            description: "Professional styling",
            duration: 45,
            price: 50.00,
            category: .styling
        ),
        Service(
            name: "Hair Extensions",
            description: "Premium extension application",
            duration: 240,
            price: 400.00,
            category: .extensions
        ),
        Service(
            name: "Deep Conditioning Treatment",
            description: "Intensive hair treatment",
            duration: 30,
            price: 40.00,
            category: .treatment
        ),
        Service(
            name: "Keratin Treatment",
            description: "Smoothing treatment",
            duration: 180,
            price: 300.00,
            category: .treatment
        )
    ]
}

enum ServiceCategory: String, Codable, CaseIterable {
    case cut = "Cut"
    case color = "Color"
    case styling = "Styling"
    case extensions = "Extensions"
    case treatment = "Treatment"
}
