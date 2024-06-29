//
//  Museum_VisionOSApp.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 16/06/24.
//

import SwiftUI

@main
struct Museum_VisionOSApp: App {

    var body: some Scene {
        WindowGroup(id: "WelcomeView") {
//            WelcomeView()
            TabViewWelcomeScreen()
        }.windowStyle(.plain)

        WindowGroup(id: "DetailView", for: String.self) { value in
            DetailView(title: value.wrappedValue!)
        }
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
