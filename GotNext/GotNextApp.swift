//
//  GotNextApp.swift
//  GotNext
//
//  Created by Kelvin Low on 2021-06-13.
//

import SwiftUI
import Firebase

@main
struct GotNextApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
