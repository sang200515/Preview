//
//  TestFile.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 18/08/2023.
//

import Foundation
import SwiftUI


struct ContentView: View {
    @State var itemHeight : CGFloat = 0
        var body: some View {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<19) { item in
                            VStack {
                                Text("Number123 \(item)")
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.yellow)
                                    .frame(height: 35)
                            }
                            Divider()
                        }

                    }
                    .frame(height: 200)
                }
                .debugBackground()

                Spacer()
            }
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
