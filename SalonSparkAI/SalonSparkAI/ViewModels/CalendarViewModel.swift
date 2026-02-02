//
//  CalendarViewModel.swift
//  SalonSparkAI
//
//  Calendar and booking management
//

import SwiftUI
import Combine

class CalendarViewModel: ObservableObject {
    @Published var selectedDate = Date()
    @Published var selectedTimeSlot: TimeSlot?
    @Published var showBookingForm = false
    
    let workingHours = (start: 9, end: 19) // 9 AM to 7 PM
    let slotDuration = 30 // minutes
    
    func getTimeSlots(for date: Date, appointments: [Appointment]) -> [TimeSlot] {
        var slots: [TimeSlot] = []
        let calendar = Calendar.current
        
        for hour in workingHours.start..<workingHours.end {
            for minute in stride(from: 0, to: 60, by: slotDuration) {
                let slotTime = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: date)!
                let slotEnd = calendar.date(byAdding: .minute, value: slotDuration, to: slotTime)!
                
                // Check if slot is booked
                let isBooked = appointments.contains { appointment in
                    calendar.isDate(appointment.date, inSameDayAs: date) &&
                    appointment.date < slotEnd &&
                    appointment.endDate > slotTime
                }
                
                slots.append(TimeSlot(
                    time: slotTime,
                    isAvailable: !isBooked,
                    appointment: isBooked ? appointments.first(where: {
                        $0.date >= slotTime && $0.date < slotEnd
                    }) : nil
                ))
            }
        }
        
        return slots
    }
    
    func selectSlot(_ slot: TimeSlot) {
        if slot.isAvailable {
            selectedTimeSlot = slot
            showBookingForm = true
        }
    }
}

struct TimeSlot: Identifiable {
    let id = UUID()
    let time: Date
    let isAvailable: Bool
    let appointment: Appointment?
    
    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }
}
