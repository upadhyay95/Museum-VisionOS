//
//  Museum_VisionOSApp.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 16/06/24.
//

import SwiftUI

@main
struct Museum_VisionOSApp: App {

    @State private var currentStyle: ImmersionStyle = .full

    var body: some Scene {
        WindowGroup(id: "WelcomeView") {
            WelcomeView()
        }.windowStyle(.plain)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: $currentStyle, in: .full)
    }
}
