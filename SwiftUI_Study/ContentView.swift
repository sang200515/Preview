//
//  ContentView.swift
//  SwiftUI_Study
//
//  Created by Sang Truong on 12/07/2023.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!2")
        }
        .padding()
        .background(.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView()
            .previewDevicesNecessary()

    }
}
