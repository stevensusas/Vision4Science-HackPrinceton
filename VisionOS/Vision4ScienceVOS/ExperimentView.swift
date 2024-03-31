

import SwiftUI
import RealityKit
import RealityKitContent
import Firebase
import FirebaseCore

struct BeakerView: View {
    
    static var cubeEntity = Entity()
    static var bottleEntity = Entity()
    @State private var subs: [EventSubscription] = []
    @Environment(ProtocolDetailViewModel.self) var viewModel

    @State var color: SimpleMaterial.Color = SimpleMaterial.Color.red
    private let colors: [SimpleMaterial.Color] = [.red, .green, .blue, .systemBrown, .systemPurple, .systemMint]
    
    var body: some View {
            RealityView { content in
                // Add the initial RealityKit content
                if let cube = try? await Entity(named: "Beaker", in: realityKitContentBundle) {
                    BeakerView.cubeEntity = cube
                    content.add(cube)
                }
                
                if let bottle = try? await Entity(named: "Erlenmeyer Flask", in: realityKitContentBundle) {
                    BeakerView.bottleEntity = bottle
                    content.add(bottle)
                }
                
                let cube = content.entities.first?.findEntity(named: "Beaker")
                let bottle = content.entities.first?.findEntity(named: "Erlenmeyer Flask")
                
                
                let event1 = content.subscribe(to: CollisionEvents.Began.self, on: cube) { ce in

                    print("💥 (EVENT1MOD) Collision between \(ce.entityA.name) and \(ce.entityB.name)")

                                }
                                Task {
                                    subs.append(event1)
                                }
                
                
                let event2 = content.subscribe(to: CollisionEvents.Began.self, on: bottle) { ce in

                    print("💥 (EVENT2MOD) Collision between \(ce.entityA.name) and \(ce.entityB.name)")

                                }
                                Task {
                                    subs.append(event2)
                                }
                
                    
                
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                BeakerView.cubeEntity.components[ModelComponent.self] = ModelComponent(mesh: .generateBox(size: 0), materials: [SimpleMaterial(color: color, isMetallic: false)])
                
                BeakerView.bottleEntity.components[ModelComponent.self] = ModelComponent(mesh: .generateBox(size: 0), materials: [SimpleMaterial(color: color, isMetallic: false)])
            }
            .gesture(
                SpatialTapGesture()
                    .targetedToAnyEntity()
                    .onEnded({ _ in
                        color = colors.randomElement()!
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(BeakerView.cubeEntity)
                    .targetedToEntity(BeakerView.cubeEntity)
                            .onChanged({ value in
                                BeakerView.cubeEntity.position = value.convert(value.location3D, from: .local, to: BeakerView.cubeEntity.parent!)
                            })
                            .onEnded({ _ in
//                                print("VIEWMODEL PROTOCOL ITEM CUBE ENTITY:")
//                                print(viewModel.protocolItem)
                                viewModel.goToNextStep()
                            })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(BeakerView.bottleEntity)
                    .onChanged({ value in
                        BeakerView.bottleEntity.position = value.convert(value.location3D, from: .local, to: BeakerView.bottleEntity.parent!)
                    })
                    .onEnded({ _ in
//                        print("VIEWMODEL PROTOCOL ITEM BOTTLE ENTITY:")
//                        print(viewModel.protocolItem)
                        viewModel.goToNextStep()
                    })
            )
        }
    }



