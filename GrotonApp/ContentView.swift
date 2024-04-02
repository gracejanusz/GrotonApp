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
    
    var body: some View {
        let keys = Keys.GrotonOrgGrotonAppGrotonAppKeys()
        var oauth2 = OAuth2(
            authURL: URL(string: "https://app.blackbaud.com/oauth/authorize")!,
            tokenURL: URL(string: "https://oauth2.sky.blackbaud.com/token")!,
            clientID: keys.clientID,
            clientSecret: keys.clientSecret,
            redirectURI: URL(string: keys.redirectURI)!
        )
        //check to see if refresh token is stored in memory somewhere
        //if it is then 
        
        if (token == nil) {
            NavigationStack(path: $path) {
                VStack {
                    NavigationLink(
                        destination: WebView(url: oauth2.getAuthorizationURL(flow: .ClientSecret)),
                        label: {
                            HStack {
                                Image(systemName: "person.badge.key.fill")
                                Text("Get Sky API Access Token")
                            }
                        }
                    )
                }.onOpenURL(perform: {url in
                    oauth2.handleRedirect(url, flow: .ClientSecret) {token, error in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        self.token = token
                    }
                })
            }
        } else {
            //Add show home screen thing.
            TokenView(token: token!)
        }
    }
}

#Preview {
    ContentView()
}
