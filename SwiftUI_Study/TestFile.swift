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
    var config = [GridItem(),GridItem(),GridItem(),GridItem(),GridItem()]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: config,spacing: 10) {
                ForEach(0...100, id: \.self) { _ in
                    ImageDataSample().imageTest
                        .frame(maxWidth: 70, maxHeight: 70)
                        .cornerRadius(20)
                }
            }
            .padding(.horizontal, 8)
        }
        .navigationTitle("Dark Mode Example")
        .navigationBarTitleDisplayMode(.automatic)
        .debugBackground()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .debugOverlay()
            .previewResizable()
//            .previewDevice(device: .iPhone13)
    }
}

/*

 on run {input, parameters}
     tell application "Xcode"
         activate -- Activate Xcode
     end tell

     set stopKey to 53 -- Mã phím "Esc"

     repeat
         -- Thực hiện hành động cần lặp lại tại đây
         tell application "System Events"
             key code 20 using command down -- Bấm cùng lúc phím Command + mã phím (20)
             key code 20 using command down -- Bấm cùng lúc phím Command + mã phím (20)
         end tell
         -- Kiểm tra nếu phím "Esc" đã được bấm
         set keyPressed to (do shell script "ioreg -c IOHIDSystem | awk '/HIDKeyboardEventDriver/{print $9}'")
         if keyPressed is stopKey then exit repeat

         delay 5 -- Đợi 1 giây trước khi lặp lại
     end repeat
     return input
 end run
 */
