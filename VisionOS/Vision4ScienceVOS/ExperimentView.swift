

import SwiftUI
import RealityKit
import RealityKitContent
import Firebase
import FirebaseCore

struct BeakerView: View {
    
//    static var cubeEntity = Entity()
//    static var bottleEntity = Entity()
//    static var tableEntity = Entity()
    @State private var beaker: Entity?
    @State private var flask: Entity?
    
    @State private var subs: [EventSubscription] = []
    @Environment(ProtocolDetailViewModel.self) var viewModel

    @State var color: SimpleMaterial.Color = SimpleMaterial.Color.red
    private let colors: [SimpleMaterial.Color] = [.red, .green, .blue, .systemBrown, .systemPurple, .systemMint]
    
    var body: some View {
            RealityView { content in
                if let scene = try? await Entity(named: "Lab_Scene", in: realityKitContentBundle) {
                    content.add(scene)
                    beaker = content.entities.first?.findEntity(named: "Beaker")
                    flask = content.entities.first?.findEntity(named: "ErlenmeyerFlask")
                }
                
//                // Add the initial RealityKit content
//                if let cube = try? await Entity(named: "Beaker", in: realityKitContentBundle) {
//                    BeakerView.cubeEntity = cube
//                    content.add(cube)
//                }
//                
//                if let bottle = try? await Entity(named: "Erlenmeyer Flask", in: realityKitContentBundle) {
//                    BeakerView.bottleEntity = bottle
//                    content.add(bottle)
//                }
//                
//                if let table = try? await Entity(named: "Lab_Table", in: realityKitContentBundle) {
//                    BeakerView.tableEntity = table
//                    content.add(table)
//                }
                
//                let cube = content.entities.first?.findEntity(named: "Beaker")
//                let bottle = content.entities.first?.findEntity(named: "Erlenmeyer Flask")
//                let table = content.entities.first?.findEntity(named: "Lab_Table")
                
                
                let event1 = content.subscribe(to: CollisionEvents.Began.self, on:  beaker) { ce in

                    print("💥 (EVENT1MOD) Collision between \(ce.entityA.name) and \(ce.entityB.name)")

                                }
                                Task {
                                    subs.append(event1)
                                }
                
                
                let event2 = content.subscribe(to: CollisionEvents.Began.self, on: flask) { ce in

                    print("💥 (EVENT2MOD) Collision between \(ce.entityA.name) and \(ce.entityB.name)")

                                }
                                Task {
                                    subs.append(event2)
                                }
                
                    
                
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
//                BeakerView.cubeEntity.components[ModelComponent.self] = ModelComponent(mesh: .generateBox(size: 0), materials: [SimpleMaterial(color: color, isMetallic: false)])
//                
//                BeakerView.bottleEntity.components[ModelComponent.self] = ModelComponent(mesh: .generateBox(size: 0), materials: [SimpleMaterial(color: color, isMetallic: false)])
//                
//                BeakerView.tableEntity.components[ModelComponent.self] = ModelComponent(mesh: .generateBox(size: 0), materials: [SimpleMaterial(color: color, isMetallic: false)])
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
                    // .targetedToEntity(BeakerView.cubeEntity)
                    .targetedToEntity(beaker ?? Entity())
                            .onChanged({ value in
//                                BeakerView.cubeEntity.position = value.convert(value.location3D, from: .local, to: BeakerView.cubeEntity.parent!)
                                guard let beaker, let parent = beaker.parent else {
                                    return
                                }
                                if var physicsBody = beaker.components[PhysicsBodyComponent.self] {
                                    physicsBody.mode = .kinematic
                                    beaker.components[PhysicsBodyComponent.self] = physicsBody
                                }
                                beaker.position = value.convert(value.location3D, from: .local, to: parent)
                            })
                            .onEnded({ _ in
//                                print("VIEWMODEL PROTOCOL ITEM CUBE ENTITY:")
//                                print(viewModel.protocolItem)
                                guard let beaker, let parent = beaker.parent else {
                                    return
                                }
                                if var physicsBody = beaker.components[PhysicsBodyComponent.self] {
                                    physicsBody.mode = .dynamic
                                    beaker.components[PhysicsBodyComponent.self] = physicsBody
                                }
                                viewModel.goToNextStep()
                            })
            )
            .gesture(
                DragGesture()
                    //.targetedToEntity(BeakerView.bottleEntity)
                    .targetedToEntity(flask ?? Entity())
                    .onChanged({ value in
//                        BeakerView.bottleEntity.position = value.convert(value.location3D, from: .local, to: BeakerView.bottleEntity.parent!)
                        guard let flask, let parent = flask.parent else {
                            return
                        }
                        if var physicsBody = flask.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            flask.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        flask.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
//                        print("VIEWMODEL PROTOCOL ITEM BOTTLE ENTITY:")
//                        print(viewModel.protocolItem)
                        guard let flask, let parent = flask.parent else {
                            return
                        }
//                        flask.components[PhysicsSimulationComponent.self]?.gravity = SIMD3(-9.81)
                        if var physicsBody = flask.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            flask.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
        }
    }



