//
//  AppData.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 18/08/2023.
//

import Foundation
import Combine
import SwiftUI


class AppData: ObservableObject {
    @Published var isDragging: Bool = false
    @Published var isPortrait: Bool = UIDevice.current.orientation.isPortrait
    @Published var isFitting: Bool = false
}
