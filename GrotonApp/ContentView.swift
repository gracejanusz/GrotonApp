//
//  ContentView.swift
//  OAuth2Authorization
//
//  Created by Seth Battis on 3/21/24.
//
//
//import SwiftUI
//import Keys
//
//struct ContentView: View {
//
//    @State private var path = NavigationPath()
//    @State private var token: OAuth2.TokenResponse?
//    @Environment(\.modelContext) private var context
//    @Environment(APIManager.self) private var apiManager: APIManager
//
//
//
//    var body: some View {
//        //check to see if refresh token is stored in memory somewhere
//        //if it is then
//        // can I add
//
//
//
//        if (apiManager.authorized) {
//            //https://api.sky.blackbaud.com/school/v1/schedules/{student_id}/meetings?start_date={start_date}[&end_date]
//
//            //Add show home screen thing.
//            //            VStack{
//            //                Button("Schedule"){
//            //                    //pass in token so scheduleview can call api and use token
//            //                    ScheduleView(token: token!)
//            //                }
//            //
//            //                Button("Assignment Center") {
//            //                    //change this assignment center view
//            //                    ScheduleView(token: token!)
//            //                }
//
//            ScheduleView(user: user)
//        } else {
//            apiManager.authorizationView(flow: .ClientSecret)
//                .onOpenURL() { url in
//                    apiManager.handleRedirect(url, flow: .ClientSecret)
//                }
//        }
//    }
//}
//
//
//#Preview {
//    ContentView()
//}
import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var token: OAuth2.TokenResponse?
    @Environment(\.modelContext) private var context
    @Environment(APIManager.self) private var apiManager: APIManager
    @State var user: User?;
    @State var error: Error?
    @State var showSchedule = false
    
    var body: some View {
        if (apiManager.authorized) {
            if user == nil {
                if error == nil {
                    ProgressView("Loading...")
                        .task {
                            do {
                                try apiManager.request(endpoint: "users/me") {user, error in
                                    self.user = user
                                    self.error = error
                                }
                            } catch {
                                self.error = error
                            }
                        }
                }else{
                    //show error visually
                    HStack{
                        Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                        Text(String(describing: error))
                    }
                }
                
                
                
            } else {
                if showSchedule {
                    ScheduleView(user: user!)
                } else {
                    // Add a button to open ScheduleView
                    VStack {
                        Button(action: {
                            showSchedule = true
                        }) {
                            Text("Open Schedule")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }
            }
        } else {
            apiManager.authorizationView(flow: .ClientSecret)
                .onOpenURL() { url in
                    apiManager.handleRedirect(url, flow: .ClientSecret)
                }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
