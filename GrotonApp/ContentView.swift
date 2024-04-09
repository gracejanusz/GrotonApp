//
//  ContentView.swift
//  OAuth2Authorization
//
//  Created by Seth Battis on 3/21/24.
//

import SwiftUI
import Keys

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var token: OAuth2.TokenResponse?
    @Environment(\.modelContext) private var context
    @Environment(APIManager.self) private var apiManager: APIManager
    
    
    var body: some View {
        //check to see if refresh token is stored in memory somewhere
        //if it is then 
        // can I add

        
        
        if (token == nil) {
            NavigationStack(path: $path) {
                VStack {
                    NavigationLink(
                        destination: WebView(url: apiManager.getAuthorizationURL(flow: .ClientSecret)),
                        label: {
                            HStack {
                                Image(systemName: "person.badge.key.fill")
                                Text("Get Sky API Access Token")
                            }
                        }
                    )
                }.onOpenURL(perform: {url in
                    apiManager.handleRedirect(url, flow: .ClientSecret)
                })
            }
        } else {
            
            //https://api.sky.blackbaud.com/school/v1/schedules/{student_id}/meetings?start_date={start_date}[&end_date]
            
            //Add show home screen thing.
//            VStack{
//                Button("Schedule"){
//                    //pass in token so scheduleview can call api and use token
//                    ScheduleView(token: token!)
//                }
//                
//                Button("Assignment Center") {
//                    //change this assignment center view
//                    ScheduleView(token: token!)
//                }
                
                    TokenView(token: token!)
            }
        }
    }


#Preview {
    ContentView()
}
