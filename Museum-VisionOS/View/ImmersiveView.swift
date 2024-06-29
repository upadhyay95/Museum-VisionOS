//
//  ImmersiveView.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 16/06/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        RealityView { realityViewContent, attachments in
            if let immersiveEntity = try? await Entity(named: Constants.EntityNames.immersiveView, in: realityKitContentBundle) {
                realityViewContent.add(immersiveEntity)
                
                // Add occluded floor
                addOccludedFloor(to: realityViewContent)
                
                // Add light for the immersive resource
                if let resource = try? await EnvironmentResource(named: Constants.EntityNames.imageBasedLight) {
                    let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 1.5)
                    immersiveEntity.components.set(iblComponent)
                    immersiveEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveEntity))
                }
                
                // Add attachments to entities
                addAttachment(to: immersiveEntity, withName: Constants.EntityNames.sculpture_st, attachmentName: Constants.EntityNames.immersiveView, attachments: attachments, offset: [-1,0.8,0])
                addAttachment(to: immersiveEntity, withName: Constants.EntityNames.sculpture_st, attachmentName: Constants.EntityGroup.sculpture_group, attachments: attachments, offset: [-0.6, -0.3, 0])
                addAttachment(to: immersiveEntity, withName: Constants.EntityNames.milos_plaster_cast, attachmentName: Constants.EntityGroup.milos_group, attachments: attachments, offset: [0, -0.25, 0])
                addAttachment(to: immersiveEntity, withName: Constants.EntityNames.ryzhanovka, attachmentName: Constants.EntityGroup.ryzhanoka_group, attachments: attachments, offset: [0.6, -0.5, 0])
            }
        } attachments: {
            Attachment(id: Constants.EntityNames.immersiveView) {
                Button(action: {
                    Task {
                        await dismissImmersiveSpace()
                        self.openWindow(id: Constants.ViewAndSpaceIDs.welcomeView)
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 250, height: 250)
                        .background(Circle().fill(Color.white).shadow(radius: 10))
                        .foregroundColor(.red)
                        .padding(10)
                        .background(Circle().fill(Color.white.opacity(0.7)))
                        .accessibilityLabel(Text("Close Immersive View"))
                        .accessibilityHint(Text("Dismisses the immersive view and returns to the welcome screen"))
                }
                .padding(.top, 20)
                .padding(.trailing, 20)
                
            }
            
            Attachment(id: Constants.EntityGroup.milos_group) {
                VStack {
                    Button(action: {
                        self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.milos_plaster_cast)
                    }){
                        LearnMoreButtonView()
                    }
                }
            }
            
            Attachment(id: Constants.EntityGroup.ryzhanoka_group) {
                VStack {
                    Button(action: {
                        self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.ryzhanovka)
                    }){
                        LearnMoreButtonView()
                    }
                }
            }
            
            Attachment(id: Constants.EntityGroup.sculpture_group) {
                Button(action: {
                    self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.sculpture_st)
                }){
                    LearnMoreButtonView()
                }
                .frame(width: 650,height: 200)
            }
        }
        .offset(z: -2000)
        .onAppear {
            dismissWindow(id: Constants.ViewAndSpaceIDs.welcomeView)
        }
    }
    
    private func addOccludedFloor(to realityViewContent: RealityViewContent) {
        let floor = ModelEntity(mesh: .generatePlane(width: 100, depth: 100), materials: [OcclusionMaterial()])
        floor.generateCollisionShapes(recursive: false)
        floor.components[PhysicsBodyComponent.self] = .init(massProperties: .default, mode: .dynamic)
        realityViewContent.add(floor)
    }
    
    private func addAttachment(to immersiveEntity: Entity, withName entityName: String, attachmentName: String, attachments: RealityViewAttachments, offset: SIMD3<Float> = [0, 0, 0]) {
        if let entity = immersiveEntity.findEntity(named: entityName) {
            if let attachment = attachments.entity(for: attachmentName) {
                attachment.position = entity.position + offset
                entity.addChild(attachment, preservingWorldTransform: true)
            }
        }
    }
}

#Preview {
    ImmersiveView()
}
