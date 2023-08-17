//
//  LongPressGestureExample.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 17/08/2023.
//

import Foundation
//
//  LongPressGestureExample.swift
//  CheatSheetIntermediate
//
//  Created by Zachary on 9/10/22.
//

import SwiftUI

struct LongPressGestureExample: View {

    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        VStack {
            Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
                .padding()
                .padding(.horizontal)
                .background(isComplete ? Color.green : Color.gray)
                .cornerRadius(10)
    //            .onTapGesture {
    //                isComplete.toggle()
    //            }
                .onLongPressGesture(minimumDuration: 2, maximumDistance: 40) {
                    isComplete.toggle()
                }

            VStack {
                Rectangle()
                    .fill(isSuccess ? Color.pink : Color.blue)
                    .frame(maxWidth: isComplete ? .infinity : 0)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)

                HStack {
                    Text("Click here")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .onLongPressGesture(
                            minimumDuration: 1,
                            maximumDistance: 50) { (isPressing) in
                                // from start of press to minimum duration
                                if isPressing {
                                    withAnimation(.easeInOut(duration: 2.5)) {
                                        isComplete = true
                                    }
                                } else {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        if !isSuccess {
                                            withAnimation(.easeInOut) {
                                                isComplete = false
                                            }
                                        }
                                    }

                                }
                            } perform: {
                                // after pressing for minimum duration
                                withAnimation(.easeInOut) {
                                    isSuccess = true
                                }
                            }



                    Text("Reset")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                        .onTapGesture {
                            isComplete = false
                            isSuccess = false
                        }
                }

            }
        }

    }
}

struct LongPressGestureExample_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureExample()
            //.previewResizable()
    }
}
