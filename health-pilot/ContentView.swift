//
//  ContentView.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI
import UIKit

class Settings: ObservableObject {
    @Published var animationDuration: Double = 3.0
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
                            .stroke(Color.blue.opacity(Double(10 - index) / 10), lineWidth: 2)
                            .frame(width: CGFloat(100 + index * 20), height: CGFloat(100 + index * 20))
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
                .onChange(of: settings.animationDuration) {
                    restartAnimation()
                }
        }
    }

    private func startAnimation() {
        withAnimation(.easeInOut(duration: settings.animationDuration)) {
            isExpanded.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + settings.animationDuration) {
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
    @State private var notificationsEnabled = false
    @State private var selectedTheme = "Light"
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Settings")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                HStack {
                    Text("Enable Notifications")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $notificationsEnabled)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack {
                    Text("Animation Speed")
                        .foregroundColor(.white)
                    Spacer()
                    Slider(value: $settings.animationDuration, in: 1...5, step: 0.5)
                        .accentColor(.blue)
                        .frame(width: 150)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                HStack {
                    Text("Theme")
                        .foregroundColor(.white)
                    Spacer()
                    Picker("", selection: $selectedTheme) {
                        Text("Light").tag("Light")
                        Text("Dark").tag("Dark")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(width: 100)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.trailing)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()
            }
        }
        .navigationBarHidden(false)
    }
}
