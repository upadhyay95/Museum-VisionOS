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
    
    var body: some View {
        //        MuseumView()
        
        RealityView { realityViewContent in
            if let immersiveEntity = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                
                realityViewContent.add(immersiveEntity)
                
                /// Add light for the immersive resource
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else {
                    return
                }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 2.0)
                immersiveEntity.components.set(iblComponent)
                immersiveEntity.components.set(ImageBasedLightReceiverComponent(imageBasedLight: immersiveEntity))
                
                // Entity Ryzhanovka
            }
        }.offset(y: -1500)
            .offset(z: -2200)
            .onAppear {
                dismissWindow(id: "WelcomeView")
            }
    }
}

#Preview {
    ImmersiveView()
}
