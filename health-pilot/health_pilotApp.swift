//
//  health_pilotApp.swift
//  health-pilot
//
//  Created by Paul Schofield on 10/20/24.
//

import SwiftUI

@main
struct health_pilotApp: App {
    @StateObject private var settings = Settings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}
