//
//  ContentView.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            FirstPageView()
        }
    }
}

struct FirstPageView: View {
    @State private var message = "Welcome to Breathe"

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text(message)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 135)
                
                ZStack {
                    ForEach(0..<10) { index in
                        Circle()
                            .stroke(Color.blue.opacity(Double(10 - index) / 10), lineWidth: 2)
                            .frame(width: CGFloat(100 + index * 20), height: CGFloat(100 + index * 20))
                    }
                }

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
