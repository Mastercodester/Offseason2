//
//  Offseason2App.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

 import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Offseason2App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var locationManager = LocationManager()
    @StateObject var eventViewModel = EventViewModel()
    @StateObject var weatherViewModel = WeatherViewModel()
    @StateObject var mapVm = MapViewModel()
    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
//            ContentView()
//            TestDataView()
//            Home_Page(event:Event())
//            AddEvent(event: Event())
            CreateUserPage(player: Player())
                .environmentObject(eventViewModel)
            .environmentObject(locationManager)
            .environmentObject(mapVm)
            .environmentObject(weatherViewModel)


        }
    }
}
