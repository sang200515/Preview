//
//  HomeState.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 16/08/2023.
//

import Foundation
import SwiftUI

class HomeState: ObservableObject{
    @StateObject private var sizeObserver = ScreenSize.shared
    @Published var screenSize: CGSize = .zero
    init(screenSize: CGSize) {
        self.screenSize = sizeObserver.viewSize
    }
}
