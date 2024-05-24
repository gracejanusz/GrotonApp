//
//
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
                        HStack {
                            Image(systemName: "exclamationmark.octagon.fill").foregroundColor(.red)
                            Text(String(describing: error))
                        }
                    }
                    
                } else {
                    NavigationStack {
                        VStack {
                            Text("myGroton App")
                                .font(.custom("Times New Roman", size: 50))
                                .bold()
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.darkRed)
                                .cornerRadius(8)

                            EmptyView()
                                    .frame(height: 30)
                            
                            Text("Hi, \(user?.first_name ?? "")")
                                .font(.custom("Times New Roman", size: 24))
                                .bold()
                                .foregroundColor(Color.darkRed)
                            
                            NavigationLink(destination: ScheduleView(user: user!)) {
                                VStack {
                                    Image("Schedule_image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                    Text("Open Schedule")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.darkRed)
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                            
                            NavigationLink(destination: AssignmentView(user: user!)) {
                                VStack {
                                    Image("Assignment_image")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 150)
                                    Text("Assignment Center")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.darkRed)
                                        .cornerRadius(8)
                                }
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
