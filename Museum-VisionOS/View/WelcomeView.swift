//
//  WelcomeView.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 16/06/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct WelcomeView: View {
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        HStack {
            Model3D(named: Constants.EntityNames.dancingMan, bundle: realityKitContentBundle)
            
            VStack(spacing: 30) {
                Text(Constants.WelcomeScreen.title)
                    .font(.extraLargeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
                    .accessibilityLabel(Constants.WelcomeScreen.title)
                
                Text(Constants.WelcomeScreen.welcomeMessage)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .accessibilityLabel(Constants.WelcomeScreen.welcomeMessage)
                
                Button(action: {
                    showImmersiveSpace.toggle()
                }) {
                    Text(Constants.WelcomeScreen.toggleLabel)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(10)
                        .accessibilityLabel(Constants.WelcomeScreen.toggleLabel)
                        .accessibilityHint(Constants.WelcomeScreen.toggleHint)
                }
                .glassBackgroundEffect()
                .cornerRadius(10)
                .tint(.accentColor)
                .foregroundStyle(.white)
                .padding(.top, 50)
                
            }
            .padding()
            .glassBackgroundEffect()
            .onChange(of: showImmersiveSpace) { _, newValue in
                Task {
                    if newValue {
                        switch await openImmersiveSpace(id: Constants.ViewAndSpaceIDs.immersiveSpace) {
                        case .opened:
                            immersiveSpaceIsShown = true
                        case .error, .userCancelled:
                            fallthrough
                        @unknown default:
                            immersiveSpaceIsShown = false
                            showImmersiveSpace = false
                        }
                    } else if immersiveSpaceIsShown {
                        await dismissImmersiveSpace()
                        immersiveSpaceIsShown = false
                    }
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    WelcomeView()
}
