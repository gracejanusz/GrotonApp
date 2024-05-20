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
                NavigationStack {
                    VStack {
                        NavigationLink(value: "schedule", label: {
                            Text("Open Schedule")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        })
                        
                        // Button to navigate to AssignmentView
                        NavigationLink(value: "assignments", label: {
                            Text("Assignment Center")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                        })
                    }.navigationDestination(for: String.self) {key in
                        if (key == "schedule") {
                            ScheduleView(user: user!)
                        } else if (key == "assignments") {
                            AssignmentView(user: user!)
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
