//
//  File.swift
//  PlaceLookupDemo
//
//  Created by Jacquese Whitson  on 5/4/23.
//

import CoreLocation
import Foundation
import MapKit

    // to use and get user location
//Dont forget about Plist add two things 

@MainActor
class LocationManager:NSObject,ObservableObject{
    @Published var location : CLLocation?
    @Published var region = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    private let locationManager = CLLocationManager()
   
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        self.region = MKCoordinateRegion(center:CLLocationCoordinate2D(latitude:  location?.coordinate.latitude ?? 0.00 , longitude:  location?.coordinate.longitude ?? 0.00 ), span: mapSpan)

    }
    
    
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {return}
        self.location = location
        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}
