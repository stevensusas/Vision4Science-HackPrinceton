import SwiftUI
import RealityKit
import RealityKitContent
struct ProtocolInputView: View {
    @ObservedObject var viewModel: ProtocolViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        Form {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            
            Button("Add Protocol") {
                let newProtocol = ScienceProtocol(title: title, description: description)
                viewModel.addProtocol(newProtocol)
                presentationMode.wrappedValue.dismiss() // Dismiss the view after adding
            }

            .navigationTitle("Add Protocol")
        }
    }
    
    struct ProtocolInputView_Previews: PreviewProvider {
        static var previews: some View {
            // Use a mock user ID or an actual one for testing
            ProtocolInputView(viewModel: ProtocolViewModel(userId: "mock_user_id"))
        }
    }
}

