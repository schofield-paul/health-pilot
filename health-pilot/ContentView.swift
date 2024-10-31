//
//  ContentView.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI
import UIKit

class Settings: ObservableObject {
    @Published var expansionDuration: Double = 3.0
    @Published var contractionDuration: Double = 3.0
}

struct ContentView: View {
    @StateObject private var settings = Settings()
    
    var body: some View {
        NavigationView {
            FirstPageView()
                .environmentObject(settings)
        }
    }
}

struct FirstPageView: View {
    @EnvironmentObject var settings: Settings
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
                            .stroke(Color.blue.opacity(opacity(for: index)), lineWidth: 2)
                            .frame(width: circleFrame(for: index), height: circleFrame(for: index))
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: SecondPageView().environmentObject(settings)) {
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

                NavigationLink(destination: SettingsPageView().environmentObject(settings)) {
                    Text("Settings")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 40)
                }
            }
            .padding()
        }
    }

    private func circleFrame(for index: Int) -> CGFloat {
        return CGFloat(100 + index * 20)
    }
    
    private func opacity(for index: Int) -> Double {
        return Double(10 - index) / 10
    }
}

struct SecondPageView: View {
    @EnvironmentObject var settings: Settings
    @State private var isExpanded = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .frame(width: isExpanded ? 200 : 10, height: isExpanded ? 200 : 10)
                .onAppear {
                    startAnimation()
                }
                .onChange(of: settings.expansionDuration) { _ in
                    restartAnimation()
                }
                .onChange(of: settings.contractionDuration) { _ in
                    restartAnimation()
                }
        }
    }

    private func startAnimation() {
        let duration = isExpanded ? settings.contractionDuration : settings.expansionDuration
        withAnimation(.easeInOut(duration: duration)) {
            isExpanded.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            startAnimation()
        }
    }
    
    private func restartAnimation() {
        isExpanded = false
        startAnimation()
    }
}

struct SettingsPageView: View {
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                VStack {
                    HStack {
                        Text("Expansion Speed")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack {
                        Text("1s")
                            .foregroundColor(.gray)
                        
                        Slider(value: $settings.expansionDuration, in: 1...5, step: 0.5)
                            .accentColor(.blue)
                            .frame(width: 150)
                            .overlay(
                                HStack {
                                    ForEach(1..<6) { tick in
                                        Spacer()
                                        Rectangle()
                                            .frame(width: 1, height: 8)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            )
                        
                        Text("5s")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Contraction Speed")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.leading)
                    
                    HStack {
                        Text("1s")
                            .foregroundColor(.gray)
                        
                        Slider(value: $settings.contractionDuration, in: 1...5, step: 0.5)
                            .accentColor(.blue)
                            .frame(width: 150)
                            .overlay(
                                HStack {
                                    ForEach(1..<6) { tick in
                                        Spacer()
                                        Rectangle()
                                            .frame(width: 1, height: 8)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                            )
                        
                        Text("5s")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 15)
                
                Spacer()
            }
        }
        .navigationBarHidden(false)
    }
}

#Preview {
    ContentView()
}
