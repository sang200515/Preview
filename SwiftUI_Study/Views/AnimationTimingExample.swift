//
//  AnimationTimingExample.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//

import SwiftUI

struct AnimationTimingExample: View {

    @State var isAnimating: Bool = false
    let timing: Double = 10.0

    var body: some View {
        VStack {
            Button("Button") {
                isAnimating.toggle()
            }
            RoundedRectangle(cornerRadius: 20)
                .frame(width: isAnimating ? 350 : 50,
                       height: 100)
                .animation(.spring(
                    response: 0.5,
                    dampingFraction: 0.7,
                    blendDuration: 1.0))
                .animation(Animation.linear(duration: timing))
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimating ? 350 : 50,
//                       height: 100)
//                .animation(Animation.easeIn(duration: timing))
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimating ? 350 : 50,
//                       height: 100)
//                .animation(Animation.easeInOut(duration: timing))
//            RoundedRectangle(cornerRadius: 20)
//                .frame(width: isAnimating ? 350 : 50,
//                       height: 100)
//                .animation(Animation.easeOut(duration: timing))
        }
    }
}

struct AnimationTimingExample_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTimingExample()
            //.previewResizable()
    }
}
