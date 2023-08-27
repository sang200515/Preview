//
//  TestFile.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 18/08/2023.
//

import Foundation
import SwiftUI


struct ContentView: View {
    @StateObject private var sizeObserver = ScreenSize.shared
    @State var gridConfig: [GridItem] = [GridItem(),GridItem(),GridItem()]
    @State private var isFullScreen = false
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridConfig, spacing: 8) {
                ForEach(0...15, id: \.self) { value in
                    DebugImage().asyncImageDebug
                        .frame(width: (sizeObserver.viewSize.width - 18) / 3, height: (sizeObserver.viewSize.width - 18) / 3)
                        .cornerRadius(20)

                }
            }

        }
    }

    private func emoji(_ value: Int) -> String {
        guard let scalar = UnicodeScalar(value) else { return "?" }
        return String(Character(scalar))
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewResizable()
    }
}

//DebugImage().debugAsyncImage
//    .frame(width: 50, height: 50)

