//
//  TabViewWelcomeScreen.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 23/06/24.
//

import SwiftUI

struct TabViewWelcomeScreen: View {
    var body: some View {
        VStack {
            TabView {
                WelcomeView()
                    .tabItem {
                        Label("Museum Window", systemImage: "window.awning.closed")
                        
                    }
                Text("Museum Volumetric")
                    .tabItem {
                        Label("Museum Volumetric", systemImage: "cube")
                    }
                ImmersiveView()
                    .tabItem {
                        Label("Museum Immersive", systemImage: "globe")
                    }
            }
        }
    }
}

#Preview {
    TabViewWelcomeScreen()
}
