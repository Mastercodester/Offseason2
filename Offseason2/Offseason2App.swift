//
//  Offseason2App.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI

@main
struct Offseason2App: App {
    @StateObject var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
        }
    }
}
