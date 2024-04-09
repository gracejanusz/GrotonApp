//
//  ScheduleView.swift
//  GrotonApp
//
//  Created by Grace Janusz on 4/7/24.
//

import Foundation
import SwiftUI
struct ScheduleView{
    //things we need
    @Environment(APIManager.self) private var apiManager: APIManager
    var studentID: Int
    @State var schedule: Schedule?
    @State var error: Error?
    
    var body: some View{
        if schedule != nil{
            VStack{
                //figure out how to show it off!
            }
            
        }else{
            if(error == nil){
            ProgressView("Loading...")
                    .task {
                        apiManager.request(endpoint: "schedules/{student_id}/meetings?start_date={start_date}[&end_date]"){schedule,error in
                            self.schedule = schedule
                            self.error = error
                            
                        }
                    }
            }else{
                //show error
            }
        }
        
        
        
    }
    
    
    
    
    
}
