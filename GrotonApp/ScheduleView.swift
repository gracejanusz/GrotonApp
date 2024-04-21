//
//  ScheduleView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/7/24.
//
//
import Foundation
import SwiftUI
struct ScheduleView: View{
    //things we need
    @Environment(APIManager.self) private var apiManager: APIManager
    var studentID: String
    @State var schedule: StudentScheduleCollection?
    @State var error: Error?
    
    var body: some View {
        if schedule == nil {
            if error == nil {
                ProgressView("Loading...")
                    .task {
                        do{
                            try apiManager.request(endpoint: "schedules/\(studentID)/meetings?start_date=2024-04-15"){schedule,error in
                                self.schedule = schedule
                                self.error = error
                            }
                        }catch{
                            self.error=error
                        }
                    }
                
            }else{
                //show error visually
                HStack{
                    Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                    Text(String(describing: error))
                }
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



