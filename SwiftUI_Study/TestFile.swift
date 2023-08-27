//
//  TestFile.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 18/08/2023.
//

import Foundation
import SwiftUI


struct ContentView: View {
        let columns = [GridItem(), GridItem(),GridItem()]

        var body: some View {
             ScrollView {
                 LazyVGrid(columns: columns,spacing: 10) {
                     ForEach(0...3, id: \.self) { value in
                         DebugImage().asyncImageDebug
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
        ContentView()   .previewResizable()
    }
}

//DebugImage().debugAsyncImage
//    .frame(width: 50, height: 50)

