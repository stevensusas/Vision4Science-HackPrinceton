

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
    @State private var cylinder: Entity?
    @State private var burner: Entity?
    @State private var bottle: Entity?
    @State private var dna: Entity?
    @State private var pipet: Entity?
    @State private var stirplate: Entity?
    @State private var magnifying: Entity?
    @State private var syringe: Entity?
    @State private var rack: Entity?
    
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
                    cylinder = content.entities.first?.findEntity(named: "GraduatedCylinder")
                    burner = content.entities.first?.findEntity(named: "BunsenBurner")
                    bottle = content.entities.first?.findEntity(named: "CultureBottle")
                    dna = content.entities.first?.findEntity(named: "Dna")
                    pipet = content.entities.first?.findEntity(named: "Pipet")
                    stirplate = content.entities.first?.findEntity(named: "Stirplate")
                    magnifying = content.entities.first?.findEntity(named: "MagnifyingGlass")
                    syringe = content.entities.first?.findEntity(named: "Syringe")
                    rack = content.entities.first?.findEntity(named: "TestTubeRack")
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
            .gesture(
                DragGesture()
                    .targetedToEntity(cylinder ?? Entity())
                    .onChanged({ value in
                        guard let cylinder, let parent = cylinder.parent else {
                            return
                        }
                        if var physicsBody = cylinder.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            cylinder.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        cylinder.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let cylinder, let parent = cylinder.parent else {
                            return
                        }
                        if var physicsBody = cylinder.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            cylinder.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(burner ?? Entity())
                    .onChanged({ value in
                        guard let burner, let parent = burner.parent else {
                            return
                        }
                        if var physicsBody = burner.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            burner.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        burner.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let burner, let parent = burner.parent else {
                            return
                        }
                        if var physicsBody = burner.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            burner.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(bottle ?? Entity())
                    .onChanged({ value in
                        guard let bottle, let parent = bottle.parent else {
                            return
                        }
                        if var physicsBody = bottle.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            bottle.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        bottle.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let bottle, let parent = bottle.parent else {
                            return
                        }
                        if var physicsBody = bottle.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            bottle.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(dna ?? Entity())
                    .onChanged({ value in
                        guard let dna, let parent = dna.parent else {
                            return
                        }
                        if var physicsBody = dna.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            dna.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        dna.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let dna, let parent = dna.parent else {
                            return
                        }
                        if var physicsBody = dna.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            dna.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(pipet ?? Entity())
                    .onChanged({ value in
                        guard let pipet, let parent = pipet.parent else {
                            return
                        }
                        if var physicsBody = pipet.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            pipet.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        pipet.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let pipet, let parent = pipet.parent else {
                            return
                        }
                        if var physicsBody = pipet.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            pipet.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(stirplate ?? Entity())
                    .onChanged({ value in
                        guard let stirplate, let parent = stirplate.parent else {
                            return
                        }
                        if var physicsBody = stirplate.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            stirplate.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        stirplate.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let stirplate, let parent = stirplate.parent else {
                            return
                        }
                        if var physicsBody = stirplate.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            stirplate.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(magnifying ?? Entity())
                    .onChanged({ value in
                        guard let magnifying, let parent = magnifying.parent else {
                            return
                        }
                        if var physicsBody = magnifying.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            magnifying.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        magnifying.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let magnifying, let parent = magnifying.parent else {
                            return
                        }
                        if var physicsBody = magnifying.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            magnifying.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(syringe ?? Entity())
                    .onChanged({ value in
                        guard let syringe, let parent = syringe.parent else {
                            return
                        }
                        if var physicsBody = syringe.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            syringe.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        syringe.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let syringe, let parent = syringe.parent else {
                            return
                        }
                        if var physicsBody = syringe.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            syringe.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
            .gesture(
                DragGesture()
                    .targetedToEntity(rack ?? Entity())
                    .onChanged({ value in
                        guard let rack, let parent = rack.parent else {
                            return
                        }
                        if var physicsBody = rack.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .kinematic
                            rack.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        rack.position = value.convert(value.location3D, from: .local, to: parent)
                    })
                    .onEnded({ _ in
                        guard let rack, let parent = rack.parent else {
                            return
                        }
                        if var physicsBody = rack.components[PhysicsBodyComponent.self] {
                            physicsBody.mode = .dynamic
                            rack.components[PhysicsBodyComponent.self] = physicsBody
                        }
                        viewModel.goToNextStep()
                    })
            )
        }
    }



