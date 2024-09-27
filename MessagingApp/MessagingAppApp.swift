//
//  MessagingAppApp.swift
//  MessagingApp
//
//  Created by Mac on 27/09/2024.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
      

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MessagingAppApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            LoginView()
        }
    }
}
