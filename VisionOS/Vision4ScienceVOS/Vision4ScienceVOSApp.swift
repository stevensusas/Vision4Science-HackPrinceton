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
    @StateObject var viewModel = ProtocolDetailViewModel(userId: "currentUser")
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
           LoginPage()
                .environmentObject(viewModel) // Provide the ViewModel to the environment
        }
        
        ImmersiveSpace (id: "Lab") {
            BeakerView(viewModel: viewModel)
            }
    }
    }

