//
//  StarView.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//
import SwiftUI

struct StarView: View {
    @State var rating:Int = 0
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }

    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            rating = index
                        }
                    }
            }
        }
    }
    var body: some View {

        CustomPreview {
            starsView
                .overlay {overlayView.mask(starsView)}

        }
    }
}

struct StarView_Previews: PreviewProvider {

    static var previews: some View {
        ContentView(appData: AppData())
    }
}


