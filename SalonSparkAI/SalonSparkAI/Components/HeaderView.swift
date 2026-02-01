//
//  HeaderView.swift
//  SalonSparkAI
//
//  Header component with salon name and notifications
//

import SwiftUI

struct HeaderView: View {
    let salonName: String
    let notificationCount: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Welcome back")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(salonName)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
                
                if notificationCount > 0 {
                    Text("\(notificationCount)")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .background(Color.red)
                        .clipShape(Circle())
                        .offset(x: 8, y: -8)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    HeaderView(salonName: "Luxe Beauty Studio", notificationCount: 3)
}
