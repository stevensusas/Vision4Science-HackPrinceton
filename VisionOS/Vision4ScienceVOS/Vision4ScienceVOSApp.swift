//
//  Vision4ScienceVOSApp.swift
//  Vision4ScienceVOS
//
//  Created by Steven Su on 2/26/24.
//

import SwiftUI
import Firebase
import FirebaseCore

@main
struct Vision4ScienceVOSApp: App {
    init() {
            FirebaseApp.configure()
        }
    var body: some Scene {
        WindowGroup {
            LoginPage()
        }
    }
}

