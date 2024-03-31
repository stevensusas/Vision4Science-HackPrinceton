import SwiftUI
import RealityKit
import RealityKitContent

struct ProtocolListView: View {
    @Environment(ProtocolDetailViewModel.self) var viewModel
    @ObservedObject var protocolViewModel: ProtocolViewModel
    var newViewModel: ProtocolDetailViewModel
    var userId: String
    
    init(userId: String) {
        self.userId = userId
        self.protocolViewModel = ProtocolViewModel(userId: userId)
        self.newViewModel = ProtocolDetailViewModel(userId: userId)
    }

    var body: some View {
        NavigationView {
            Model3D(named: "Scene", bundle: realityKitContentBundle)
                .padding(.bottom, 50)
            List(protocolViewModel.protocols) { protocolItem in
                NavigationLink(destination: ProtocolDetailView(protocolId: protocolItem.id)) {
                    VStack(alignment: .leading) {
                        Text(protocolItem.title)
                            .font(.headline)
                        Text(protocolItem.description)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Protocols")
            .navigationBarItems(trailing: NavigationLink(destination: ProtocolInputView(viewModel: protocolViewModel)) {
                Image(systemName: "plus")
            })
            .onAppear {
//                print("VIEW MODEL (USER ID) IN PROTOCOL LIST VIEW")
//                print(viewModel.getUserId())
                viewModel.setUserId(uid: newViewModel.getUserId())
                viewModel.setProtocolItem(pItem: newViewModel.getProtocolItem())
            }
        }
    }
}
