//
//  ContentView.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = "Hello, iOS!"
    @State private var count: Int = 0  

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.white)
                Text(message)
                    .foregroundColor(.white)
                    .padding()
                
                Text("Count: \(count)")
                    .foregroundColor(.white)
                    .padding()
                
                Button("Tap me!") {
                    count += 1
                    message = "Button tapped \(count) time\(count == 1 ? "" : "s")!"
                }
                .foregroundColor(.black)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
