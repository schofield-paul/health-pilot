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
                
                NavigationLink(destination: SecondPageView()) {
                    Text("Start")
                        .font(.title2)
                        .foregroundColor(.blue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 50)
            }
            .padding()
        }
    }
}


struct SecondPageView: View {
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .frame(width: isExpanded ? 200 : 10, height: isExpanded ? 200 : 10)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 3)) {
                            isExpanded = true
                        }
                        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                            withAnimation(.easeInOut(duration: 3)) {
                                isExpanded.toggle()
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
