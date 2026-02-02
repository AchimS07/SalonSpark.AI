//
//  CalendarView.swift
//  SalonSparkAI - Full Calendar with Booking
//

import SwiftUI

struct CalendarView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = CalendarViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Calendar
                DatePicker("Select Date", selection: $viewModel.selectedDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                Divider()
                
                // Time Slots
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.getTimeSlots(for: viewModel.selectedDate, appointments: appState.appointments)) { slot in
                            TimeSlotRow(slot: slot) {
                                viewModel.selectSlot(slot)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Calendar")
            .sheet(isPresented: $viewModel.showBookingForm) {
                if let slot = viewModel.selectedTimeSlot {
                    BookingFormView(preselectedDate: slot.time)
                }
            }
        }
    }
}

struct TimeSlotRow: View {
    let slot: TimeSlot
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(slot.timeString)
                    .font(.headline)
                Spacer()
                if let appointment = slot.appointment {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(appointment.clientName)
                            .font(.subheadline)
                        Text(appointment.serviceName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    Text("Available")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(slot.isAvailable ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .disabled(!slot.isAvailable)
    }
}
