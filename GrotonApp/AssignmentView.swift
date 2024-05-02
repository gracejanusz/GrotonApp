////
////  AssignmentView.swift
////  GrotonApp
////
////  Created by Grace Janusz on 5/2/24.
////
//
//import Foundation
//import SwiftUI
//struct AssignmentView: View{
//    //things we need
//    @Environment(APIManager.self) private var apiManager: APIManager
//    var studentID: String
//    @State var assignment: AssignmentCollection?
//    @State var error: Error?
//    
//    var body: some View {
//        if assignment == nil {
//            if error == nil {
//                ProgressView("Loading...")
//                    .task {
//                        do{
//                            try apiManager.request(endpoint:
//                                                    
//                                                    "schedules/\(studentID)/meetings?start_date=2024-04-15"){schedule,error in
//                                self.assignment = assignment
//                                self.error = error
//                            }
//                        }catch{
//                            self.error=error
//                        }
//                    }
//                
//                
//            }
//        }
//    }
//}
