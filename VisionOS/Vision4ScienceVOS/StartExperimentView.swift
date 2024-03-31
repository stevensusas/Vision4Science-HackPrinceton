import SwiftUI

struct StartExperimentView: View {
    @ObservedObject var viewModel: ProtocolDetailViewModel

    var body: some View {
        VStack {
            // Use the currentStepIndex to access the current step
            if let steps = viewModel.protocolItem?.steps, viewModel.progress < steps.count {
                Text(steps[viewModel.progress])
            } else {
                Text("No steps available or the experiment has concluded.")
            }
        }
        .navigationTitle("Start Experiment")
        .navigationBarTitleDisplayMode(.inline)
    }
}
