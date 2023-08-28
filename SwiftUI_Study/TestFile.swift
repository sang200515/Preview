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
    var body: some View {
        ScrollView {
            ForEach(1...10, id: \.self) { i in
                if let text = Bool.randomBoolOptional() {
                    VStack(spacing: 20) {
                        ImageDataSample().imageTest
                            .debugBackground()
                        Text(verbatim: .randomString(100))
                    }
                }
            }
        }
        .navigationTitle("Dark Mode Example")
        .navigationBarTitleDisplayMode(.automatic)
        .debugBackground()
        .readSize { size in

        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .debugOverlay()
            .previewResizable()
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
