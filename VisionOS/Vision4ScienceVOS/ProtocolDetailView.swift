import SwiftUI
import RealityKit
import RealityKitContent
import Firebase
import FirebaseAuth


struct ProtocolDetailView: View {
    @ObservedObject var viewModel: ProtocolDetailViewModel
    var protocolId: String
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @State private var navigateToStartExperiment = false
    
    
    func setEnvironment() {
        .environmentObject(viewModel)
    }
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Button("Start Experiment") {
                                    Task {
                                        let result = await openImmersiveSpace(id: "Lab")
                                        if case .error = result {
                                            print("An error occurred")
                                        } else {
                                            navigateToStartExperiment = true
                                        }
                                    }
                                }

                NavigationLink(destination: StartExperimentView(viewModel: viewModel), isActive: $navigateToStartExperiment) {
                                    EmptyView()
                                }

                
                Model3D(named: "Scene", bundle: realityKitContentBundle)
                    .padding(.bottom, 50)
                if let protocolItem = viewModel.protocolItem {
                    Group {
                        Text(protocolItem.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top)

                        Divider()

                        if let reagents = protocolItem.reagents_objects, !reagents.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Reagents and Objects:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 5)

                                ForEach(reagents, id: \.self) { reagent in
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .font(.caption)
                                            .foregroundColor(.blue)
                                        Text(reagent)
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }

                        Divider()

                        if let steps = protocolItem.steps, !steps.isEmpty {
                            VStack(alignment: .leading) {
                                Text("Steps:")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 5)

                                ForEach(steps.indices, id: \.self) { index in
                                    HStack(alignment: .top) {
                                        Text("\(index + 1).")
                                            .fontWeight(.bold)
                                        Text(steps[index])
                                    }
                                    .padding(.leading, 10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                } else {
                    Spacer()
                    Text("Loading...")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .navigationTitle("Protocol Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchProtocolDetail(protocolId: protocolId)
        }
    }
}


