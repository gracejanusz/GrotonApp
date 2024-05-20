//
//  GrotonApp.swift
//  GrotonApp
//  Created by Seth Battis on 3/21/24.
//

import SwiftUI
import SwiftData
import Keys

@main
struct GrotonAppApp: App {
    @State var apiManager: APIManager
    var body: some Scene {
        WindowGroup {
            ContentView().environment(apiManager)
        }
    }
    init() {
        let keys = Keys.GrotonOrgGrotonAppGrotonAppKeys()
        apiManager = APIManager(
            authURL: URL(string: "https://app.blackbaud.com/oauth/authorize")!,
            tokenURL: URL(string: "https://oauth2.sky.blackbaud.com/token")!,
            clientID: keys.clientID,
            clientSecret: keys.clientSecret,
            redirectURI: URL(string: keys.redirectURI)!,
            baseURL: URL(string: "https://api.sky.blackbaud.com/school/v1/")!,
            headers: [("Bb-Api-Subscription-Key", keys.subscriptionAccessKey)]
        )
    }
}
