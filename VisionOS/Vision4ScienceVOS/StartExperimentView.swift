import SwiftUI

struct StartExperimentView: View {
    @Environment(ProtocolDetailViewModel.self) var viewModel

    var body: some View {
        VStack {
            // Use the currentStepIndex to access the current step
            if let steps = viewModel.protocolItem?.steps, viewModel.progress < steps.count {
                Text(steps[viewModel.progress]).font(.system(size: 24))
            } else {
                Text("No steps available or the experiment has concluded.").font(.system(size: 24))
            }
        }
        .navigationTitle("Experiment")
        .navigationBarTitleDisplayMode(.inline)
    }
}
