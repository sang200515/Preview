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
    var body: some View {
            ScrollView {
                ForEach(1...10, id: \.self) { i in
                    VStack(spacing: 20) {
                        ImageDataSample().imageTest
                        Text(verbatim: .randomString(100))
                    }
                }
            }
            .navigationTitle("Dark Mode Example")
            .navigationBarTitleDisplayMode(.automatic)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewResizable()
    }
}
