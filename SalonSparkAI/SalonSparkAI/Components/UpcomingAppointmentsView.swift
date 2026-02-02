//
//  UpcomingAppointmentsView.swift
//  SalonSparkAI
//
//  Upcoming appointments list
//

import SwiftUI

struct UpcomingAppointmentsView: View {
    let appointments: [Appointment]
    let onViewAll: () -> Void
    
    var body: some View {
        if appointments.isEmpty {
            EmptyView()
        } else {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Text("Coming Up")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
                    Text("Today")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                // Appointments list
                VStack(spacing: 12) {
                    ForEach(Array(appointments.prefix(3).enumerated()), id: \.element.id) { index, appointment in
                        appointmentRow(appointment, index: index)
                    }
                }
                
                // View all button
                if appointments.count > 3 {
                    Button(action: onViewAll) {
                        Text("View all \(appointments.count) appointments")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                }
            }
            .padding(20)
            .background(Color.cardBackground)
            .cornerRadius(16)
            .shadow(color: Color.cardShadow, radius: 8, x: 0, y: 2)
        }
    }
    
    // MARK: - Appointment Row
    private func appointmentRow(_ appointment: Appointment, index: Int) -> some View {
        HStack(spacing: 12) {
            // Avatar
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                if let avatar = appointment.avatar {
                    AsyncImage(url: URL(string: avatar)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.blue)
                    }
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                }
            }
            
            // Client info
            VStack(alignment: .leading, spacing: 2) {
                Text(appointment.clientName)
                    .font(.system(size: 14, weight: .semibold))
                    .lineLimit(1)
                
                Text(appointment.service)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Time
            HStack(spacing: 4) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                
                Text(appointment.time)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.05))
        )
        .fadeUpAnimation(delay: Double(index) * 0.1)
    }
}

#Preview {
    VStack(spacing: 20) {
        UpcomingAppointmentsView(
            appointments: Appointment.mockAppointments,
            onViewAll: {}
        )
        
        UpcomingAppointmentsView(
            appointments: [],
            onViewAll: {}
        )
    }
    .padding()
}
