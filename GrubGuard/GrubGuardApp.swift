//
//  GrubGuardApp.swift
//  GrubGuard
//
//  Created by Nestor on 4/8/25.
//

import SwiftUI

@main
struct GrubGuardApp: App {
    // Register AppDelegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}

