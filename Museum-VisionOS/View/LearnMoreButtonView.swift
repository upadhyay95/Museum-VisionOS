//
//  LeanMoreView.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 24/06/24.
//

import SwiftUI

struct LearnMoreButtonView: View {
    var body: some View {
        Text(Constants.ImmersiveViewScreen.knowMore)
            .frame(width: 650,height: 200)
            .font(.system(size: 100))
            .padding(.vertical, 40)
            .padding(.horizontal, 60)
            .glassBackgroundEffect()
    }
}

#Preview {
    LearnMoreButtonView()
}
