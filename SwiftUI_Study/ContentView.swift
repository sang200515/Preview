//
//  ContentView.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 12/07/2023.
//
import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject var appData: AppData
    var body: some View {
        VStack {
            Text(appData.isDragging ? "true" : "false")
            Text("Hello, Worl123123123123123d123123213123123123!")
                .padding()
                .background(Color.green)
            
                .debugOverlay()

            Rectangle()
                .frame(maxWidth: 100, maxHeight: 300)
                .foregroundColor(.blue)
                .debugOverlay()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appData: AppData())
            .previewResizable()
    }
}
import SwiftUI

struct DebugView: View {
    @Binding var size: CGSize


    @ViewBuilder
    var body: some View {
        VStack {
            Text("w: \(Int(size.width)), h: \(Int(size.height))")
                .font(.system(size: 18))
                .foregroundColor(.white)
                .padding(4)
                .background(Color.black.opacity(0.3))
                .cornerRadius(4)
                .frame(width: 250)
        }
    }
}
import SwiftUI

struct DebugOverlayModifier: ViewModifier {
    @State private var size: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            self.size = geometry.size
                        }
                }
            )
            .overlay(alignment: .center, content: {
                VStack {

                    DebugView(size: $size)
                        .offset(x:250)
                }
            })
    }
}

extension View {
    func debugOverlay() -> some View {
        self.modifier(DebugOverlayModifier())
    }
}
