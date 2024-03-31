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
    @State private var viewModel: ProtocolDetailViewModel;
    
    init() {
            FirebaseApp.configure()
            viewModel = ProtocolDetailViewModel(userId: "currentUser")
        }
    
    var body: some Scene {
        WindowGroup {
           LoginPage()
                .environment(viewModel) // Provide the ViewModel to the environment
        }
        
        ImmersiveSpace (id: "Lab") {
            // BeakerView(viewModel: viewModel)
            BeakerView().environment(viewModel)
            }
    }
    }

