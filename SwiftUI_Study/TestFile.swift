//
//  TestFile.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 18/08/2023.
//

import Foundation
import SwiftUI


struct ContentView: View {
    @StateObject private var presenter = DebugDataSource.shared
    var config = [GridItem(),GridItem(),GridItem(),GridItem(),GridItem()]
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0...12, id: \.self) { _ in
                        Color.gray
                            .frame(width: presenter.isPadUI ? 159 : (presenter.viewSize.width - 42) / 2, height: presenter.isPadUI ? 159 : presenter.viewSize.width / 1.9)
                            .cornerRadius(20)
                            .overlay {
                                AsyncImage(url: presenter.randomOneURL) { imag in
                                    imag.resizable()
                                        .scaledToFill()
                                        .debugOverlay()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                            .cornerRadius(20)

                    }
                }
                
            }
        }
        .padding(.horizontal, 8)
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

