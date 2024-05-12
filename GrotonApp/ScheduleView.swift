//
//  ScheduleView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/7/24.
import Foundation
import SwiftUI

struct ScheduleView: View {
    @Environment(APIManager.self) private var apiManager: APIManager
    var user: User
    @State private var schedule: StudentScheduleCollection?
    @State private var error: Error?
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            Color.darkRed
                .ignoresSafeArea()
            
            scheduleView
                .padding(.top, 20)
        }
    }
    
    private var scheduleView: some View {
        VStack {
            HStack {
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
                    fetchSchedule(for: selectedDate)
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title) // Increased button heading size
                }
                
                let weekday = formattedDate(selectedDate, format: "EEEE")
                let abbreviatedDate = formattedDate(selectedDate, format: "MMM d")
                
                Text("\(weekday) \(abbreviatedDate)")
                    .bold()
                    .foregroundColor(.white) // Text color set to white
                    .font(.headline) // Increased text size
                    .frame(maxWidth: .infinity)
                    .background(Color.clear) // Transparent background
                    
                Spacer()
                
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                    fetchSchedule(for: selectedDate)
                }) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.title) // Increased button heading size
                }
            }
            .padding(.horizontal)
            if let schedule = schedule {
                let sortedSchedule = schedule.value.sorted { $0.start_time ?? "" < $1.start_time ?? "" }
                List {
                    Spacer()
                    
                    ForEach(sortedSchedule) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(item.course_title ?? "Unnamed Course")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Text(formatTimeRange(start: item.start_time, end: item.end_time))
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("Room \(item.room_number ?? "Unnamed Room")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("Teacher: \(item.faculty_lastname ?? "Unknown Teacher")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.white)
                    }
                }
            } else if error != nil {
                HStack{
                    Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                    Text(String(describing: error))
                }
            } else {
                ProgressView("Loading...")
                    .task {
                        fetchSchedule(for: selectedDate)
                    }
            }
        }
    }
    
    private func fetchSchedule(for date: Date) {
        do {
            if let userId = user.id {
                try apiManager.request(endpoint: "schedules/\(userId)/meetings?start_date=2024-05-06") { schedule, error in
                    self.schedule = schedule
                    self.error = error
                }
            } else {
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"])
            }
        } catch {
            self.error = error
        }
    }
    
    private func formattedDate(_ date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    private func formatTimeRange(start: String?, end: String?) -> String {
        guard let startTime = start, let endTime = end else {
            return "--"
        }
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatterInput.timeZone = TimeZone(identifier: "UTC")
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "H:mm"
        dateFormatterOutput.timeZone = TimeZone(identifier: "America/New_York")
        
        if let startDate = dateFormatterInput.date(from: startTime), let endDate = dateFormatterInput.date(from: endTime) {
            return "\(dateFormatterOutput.string(from: startDate)) - \(dateFormatterOutput.string(from: endDate))"
        } else {
            return "--"
        }
    }
}

extension Color {
    static let darkRed = Color(red: 139/255, green: 0/255, blue: 0/255)
}
