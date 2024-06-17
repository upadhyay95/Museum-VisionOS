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
            WelcomeView()
        }.windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
