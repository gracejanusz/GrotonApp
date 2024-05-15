//
//  ContentView.swift
//  OAuth2Authorization
//
//  Created by Seth Battis on 3/21/24.
import SwiftUI
import Keys

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var token: OAuth2.TokenResponse?
    @Environment(\.modelContext) private var context
    @Environment(APIManager.self) private var apiManager: APIManager
    @State var user: User?;
    @State var error: Error?
    @State var showSchedule = false
    @State private var showAssignmentView = false
    
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
                VStack {
                    if showSchedule {
                        ScheduleView(user: user!)
                            .padding()
                    }
                    if showAssignmentView {
                        AssignmentView(user: user!)
                            .padding()
                    } else {
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
                        
                        // Button to navigate to AssignmentView
                        Button(action: {
                            showAssignmentView = true
                        }) {
                            Text("Assignment Center")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
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
