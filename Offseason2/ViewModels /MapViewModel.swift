//
//  MapViewModel.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/19/23.
//

import Foundation
import CoreLocation
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseDatabase
import MapKit
import SwiftUI



class MapViewModel : ObservableObject {
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    var loVm = LocationManager()
    
    @Published  var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.331578, longitude: -83.045839), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @Published var eventLocation: Event {
        /// everytime the map location is set update the map region so they match ↓
        didSet {
            updateMapRegion(eventLocation)
        }
    }


    
    init(){
         
        self.eventLocation = Event()

        
    }
    
    
    
    
    
    // funcs
    
    
    
    func showNextEvent(_ event: Event){
        withAnimation(.easeInOut){
            eventLocation = event
            // this will close the list row ↑
        }
    }
    
    
    func updateMapRegion(_ event : Event){
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: event.coordinate,
                span: mapSpan)
        }
    }
    
    
    
    
    
    
}
