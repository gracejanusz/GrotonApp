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
        VStack {
            Image("GrotonLogo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 50)
            
            Spacer()
            
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
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                            Text(String(describing: error))
                        }
                    }
                    
                } else {
                    NavigationStack {
                        VStack {
                            NavigationLink(destination: ScheduleView(user: user!)) {
                                Text("Open Schedule")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.maroon)
                                    .cornerRadius(8)
                            }
                            
                            NavigationLink(destination: AssignmentView(user: user!)) {
                                Text("Assignment Center")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.maroon)
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
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
