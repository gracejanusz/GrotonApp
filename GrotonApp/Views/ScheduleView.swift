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
                    schedule = nil
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
                let weekday = formattedDate(selectedDate, format: "EEEE")
                let abbreviatedDate = formattedDate(selectedDate, format: "MMM d")
                
                Text("\(weekday) \(abbreviatedDate)")
                    .bold()
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(Color.clear)
                    
                Spacer()
                
                Button(action: {
                    selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
                    schedule = nil
                }) {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                        .font(.title) 
                }
            }
            .padding(.horizontal)
            if (schedule != nil) {
                let sortedSchedule = schedule!.value.sorted { $0.start_time ?? "" < $1.start_time ?? "" }
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
                                .opacity(item.room_number != nil ? 1 : 0) // Conditionally show room number
                            
                            if let teacher = item.faculty_lastname {
                                Text("Teacher: \(teacher)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
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
                List {
                    ProgressView("Loading...")
                        .task {
                            fetchSchedule(for: selectedDate)
                        }.padding()
                }
            }
        }
    }
    
    private func fetchSchedule(for date: Date) {
        do {
            if let userId = user.id {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                try apiManager.request(endpoint: "schedules/\(userId)/meetings?start_date=\(formatter.string(from: date))") { schedule, error in
                    self.schedule = schedule
                    self.error = error
                }
            } else {
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID: \(String(describing:  user))"])
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
        let dateInput = DateFormatter()
        dateInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'+00:00'"
        dateInput.timeZone = .current
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "H:mm"
        dateFormatterOutput.timeZone = TimeZone.current
        if let startDate = dateInput.date(from: startTime), let endDate = dateInput.date(from: endTime) {
            return "\(dateFormatterOutput.string(from: startDate)) - \(dateFormatterOutput.string(from: endDate))"
        } else {
            return "--"
        }
    }
}

extension Color {
    static let darkRed = Color(red: 139/255, green: 0/255, blue: 0/255)
}
