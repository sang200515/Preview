//
//  Background_OverlayExample.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//

import Foundation
import SwiftUI

struct Background_OverlayExample: View {
    var body: some View {
        Image(systemName: "heart.fill")
                   .font(.system(size: 40))
                   .foregroundColor(Color.white)
                   .background(
                       Circle()
                           .fill(
                               LinearGradient(
                                   gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                           )
                           .frame(width: 100, height: 100)
                           .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)), radius: 10, x: 0.0, y: 10)
                           .overlay(
                               Circle()
                                   .fill(Color.blue)
                                   .frame(width: 35, height: 35)
                                   .overlay(
                                       Text("5")
                                           .font(.headline)
                                           .foregroundColor(.white)
                                   )
                                   .shadow(color: Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5)), radius: 10, x: 5, y: 5)
                               , alignment: .topTrailing)
                   )
    }
}

struct Background_OverlayExample_Previews: PreviewProvider {
    static var previews: some View {
        Background_OverlayExample()
            .previewResizable()
    }
}
