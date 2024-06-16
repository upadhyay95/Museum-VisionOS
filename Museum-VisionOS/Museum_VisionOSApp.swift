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
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.full), in: .full)
    }
}
