//
//  TransitionExample.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//

import Foundation
import SwiftUI

struct TransitionExample: View {

    @State var showView: Bool = false

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack{
                Button("Button") {
                    showView.toggle()
                }
                Spacer()
            }
            if showView {
                Image(systemName: "heart")
                    .resizable()
                    .frame(height: UIScreen.main.bounds.height/2)
//                    .transition(.move(edge: .bottom))
//                    .transition(AnyTransition.scale.animation(.easeInOut))
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading),
                        removal: AnyTransition.opacity.animation(.easeInOut)))
                    .animation(.easeInOut)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransitionExample_Previews: PreviewProvider {
    static var previews: some View {
        TransitionExample()
            //.previewResizable()
    }
}
