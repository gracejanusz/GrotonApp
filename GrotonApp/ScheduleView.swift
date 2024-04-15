//
//  ScheduleView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/7/24.
//
//
import Foundation
import SwiftUI
struct ScheduleView{
    //things we need
    @Environment(APIManager.self) private var apiManager: APIManager
    var studentID: Int
    @State var schedule: StudentScheduleCollection?
    @State var error: Error?
    
    var body: some View {
        if schedule == nil {
            if error == nil {
                ProgressView("Loading...")
                    .task {
                        do{
                            try apiManager.request(endpoint: "schedules/\(studentID)/meetings?start_date=\(Date.now.formatted(.iso8601))"){schedule,error in
                                self.schedule = schedule
                                self.error = error
                            }
                        }catch{
                            self.error=error
                        }
                    }
                
            }else{
                //show error visually
                 Text(error!.localizedDescription)
            }
        }else{
            VStack{
                //figure out how to show it off!
                ForEach(schedule!.value){ item in
                    Text(item.course_title ?? "Unnamed Course")
                }
            }
        }
    }
}



