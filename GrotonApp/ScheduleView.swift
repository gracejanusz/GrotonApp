//
//  ScheduleView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/7/24.
//
////
//import Foundation
//import SwiftUI
//struct ScheduleView: View{
//    @Environment(APIManager.self) private var apiManager: APIManager
//    var user: User?;
//    @State var schedule: StudentScheduleCollection?
//    @State var error: Error?
//    
//    var body: some View {
//        if schedule == nil {
//                if error == nil {
//                ProgressView("Loading...")
//                    .task {
//                        do{
//                            try apiManager.request(endpoint: "schedules/\(user.id)/meetings?start_date=2024-04-15"){schedule, error in
//                                self.schedule = schedule
//                                self.error = error
//                            }
//                        }catch{
//                            self.error=error
//                        }
//                    }
//                
//            }else{
//                VStack{
//                    //figure out how to show it off!
//                    Spacer()
//                    Text(Date().formatted()).background(Color.blue).foregroundColor(.white)
//                    ForEach(schedule!.value){ item in
//                        Text(item.course_title ?? "Unnamed Course")
//                        Text(formatTimeRange(start: item.start_time, end: item.end_time))
//                        Text(item.room_name ?? "Unnamed Room")
//                        Spacer()
//                    }
//                }
//            }
//        }
//        
//        func formatTimeRange(start: String?, end: String?) -> String {
//            guard let startTime = start, let endTime = end else {
//                return "--"
//            }
//            return "\(startTime) - \(endTime)"
//        }
//    }
//}
//
//
import SwiftUI

struct ScheduleView: View {
    @Environment(APIManager.self) private var apiManager: APIManager
    var user: User?
    @State private var schedule: StudentScheduleCollection?
    @State private var error: Error?
    
    var body: some View {
        Group {
            if let schedule = schedule {
                VStack {
                    Spacer()
                    Text(Date().formatted()).background(Color.blue).foregroundColor(.white)
                    ForEach(schedule.value) { item in
                        VStack {
                            Text(item.course_title ?? "Unnamed Course")
                            Text(formatTimeRange(start: item.start_time, end: item.end_time))
                            Text(item.room_name ?? "Unnamed Room")
                        }
                        Spacer()
                    }
                }
            } else if error != nil {
                HStack{
                    Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                    Text(String(describing: error))
                }
            } else {
                ProgressView("Loading...")
                    .onAppear {
                        fetchSchedule(user)
                    }
            }
        }
    }
    
    func fetchSchedule(user: User) {
        do {
            if let userId = Int(user.id) {
                try apiManager.request(endpoint: "schedules/\(userId)/meetings?start_date=2024-04-15") { schedule, error in
                    self.schedule = schedule
                    self.error = error
                }
            } else {
                // Handle invalid user ID case
                self.error = NSError(domain: "InvalidUserID", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid user ID"])
            }
        } catch {
            self.error = error
        }
    }
    
    func formatTimeRange(start: String?, end: String?) -> String {
                guard let startTime = start, let endTime = end else {
                    return "--"
                }
                return "\(startTime) - \(endTime)"
            }
}
