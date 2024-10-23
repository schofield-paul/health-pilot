//
//  ContentView.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            FirstPageView()
        }
    }
}

struct FirstPageView: View {
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
                
                NavigationLink(destination: SecondPageView()) {
                    Text("Go to Next Page")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

struct SecondPageView: View {
    @State private var userInput: String = ""

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            VStack {
                Text("This is the second page!")
                    .foregroundColor(.white)
                    .padding()

                TextField("Enter something", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()

                Text("You typed: \(userInput)")
                    .foregroundColor(.white)
                    .padding()

                NavigationLink(destination: FirstPageView()) {
                    Text("Back to First Page")
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

