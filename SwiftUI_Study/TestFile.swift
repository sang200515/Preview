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
                ForEach(0...65, id: \.self) { value in
                    VStack {
//                        DebugDataSource.Image().asyncImageDebug
//                            .frame(width: .infinity, height: 140)
                        Text(DebugDataSource.StringDataSample().random(20))
                            .debugBackground()
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewResizable()
    }
}

//DebugImage().debugAsyncImage
//    .frame(width: 50, height: 50)

