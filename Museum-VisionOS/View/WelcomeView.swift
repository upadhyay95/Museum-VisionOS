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
            VStack(spacing: 30) {
                Model3D(named: Constants.EntityNames.drummer, bundle: realityKitContentBundle)
                .padding()
                
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
                .padding(.top, 50)
                .cornerRadius(10)
            }
        .padding()
        .background(LinearGradient(gradient: Constants.GradientBG.eternalConstance,
                                   startPoint: .leading,
                                   endPoint: .trailing))
        .cornerRadius(10)
        .shadow(radius: 10)
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

#Preview(windowStyle: .volumetric) {
    WelcomeView()
}

