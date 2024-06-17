//
//  SculptureModel.swift
//  Museum-VisionOS
//
//  Created by Abhishek on 18/06/24.
//

import Foundation

struct SculptureModel: Identifiable, Hashable {
    let id = UUID()
    let title : String
    let description: String
}
