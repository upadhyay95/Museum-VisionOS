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

    var body: some View {
        
        RealityView { realityViewContent, attachments in
            if let immersiveEntity = try? await Entity(named: Constants.EntityNames.immersiveView, in: realityKitContentBundle) {
                
                realityViewContent.add(immersiveEntity)
                
                // Add light for the immersive resource
                guard let resource = try? await EnvironmentResource(named: Constants.EntityNames.imageBasedLight) else {
                    return
                }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 2.0)
                immersiveEntity.components.set(iblComponent)
                immersiveEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveEntity))
                
                if let ryzhanokaGroup = immersiveEntity.findEntity(named: Constants.EntityNames.ryzhanovka) {
                    if let ryzhanokaGroupAttachment = attachments.entity(for: Constants.EntityGroup.ryzhanoka_group) {
                        ryzhanokaGroupAttachment.position = ryzhanokaGroup.position
                        ryzhanokaGroup.addChild(ryzhanokaGroupAttachment, preservingWorldTransform: true)
                    }
                }
                
                if let milosGroup = immersiveEntity.findEntity(named: Constants.EntityNames.milos_plaster_cast) {
                    if let milosGroupAttachment = attachments.entity(for: Constants.EntityGroup.milos_group) {
                        milosGroupAttachment.position = milosGroup.position
                        milosGroup.addChild(milosGroupAttachment, preservingWorldTransform: true)
                    }
                }
                
                if let sculptureGroup = immersiveEntity.findEntity(named: Constants.EntityNames.sculpture_st) {
                    if let sculptureGroupAttachment = attachments.entity(for: Constants.EntityGroup.sculpture_group) {
                        sculptureGroupAttachment.position = sculptureGroup.position
                        sculptureGroup.addChild(sculptureGroupAttachment, preservingWorldTransform: true)
                    }
                }
            }
        } attachments: {
            Attachment(id: Constants.EntityGroup.milos_group) {
                VStack {
                    Button(action: {
                        self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.milos_plaster_cast)
                    }, label: {
                        LearnMoreButtonView()
                    })
                }
            }
            
            Attachment(id: Constants.EntityGroup.ryzhanoka_group) {
                VStack {
                    Button(action: {
                        self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.ryzhanovka)
                    }, label: {
                        LearnMoreButtonView()
                    })
                }
            }
            
            Attachment(id: Constants.EntityGroup.sculpture_group) {
                VStack {
                    Button(action: {
                        self.openWindow(id: Constants.ViewAndSpaceIDs.detailView, value: Constants.EntityNames.sculpture_st)
                    }, label: {
                        LearnMoreButtonView()
                    })
                }
            }
        }
//        .offset(y: -1000)
        .offset(z: -2000)
        .onAppear {
            dismissWindow(id: Constants.ViewAndSpaceIDs.welcomeView)
        }
    }
}

#Preview {
    ImmersiveView()
}
