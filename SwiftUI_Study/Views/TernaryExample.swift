//
//  TernaryExample.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//


import SwiftUI

struct TernaryExample: View {

    @State var isStartingState: Bool = false

    var body: some View {
        VStack{
            Button("Button: \(isStartingState.description)") {
                withAnimation {
                    isStartingState.toggle()
                }
            }
            .foregroundColor(Color.secondary)
            .frame(width: 120, height: 60)
            .background(Color.red)
            .cornerRadius(20)

            Text(isStartingState ? "starting state" : "ending state")

            RoundedRectangle(cornerRadius: isStartingState ? 25 : 100)
                .fill(isStartingState ? Color.red : Color.blue)
                .frame(width: isStartingState ? 200 : 400,
                       height: isStartingState ? 100 : 100)
        }
    }
}

struct TernaryExample_Previews: PreviewProvider {
    static var previews: some View {
        TernaryExample()
//            .previewResizable()
    }
}
