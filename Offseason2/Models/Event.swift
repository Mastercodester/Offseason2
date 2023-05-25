//
//  Spot.swift
//  Snacktacku;ar
//
//  Created by Jacquese Whitson  on 4/25/23.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

// this is the thats going to get added to firebase 
struct Event: Identifiable,Codable,Equatable {
    @DocumentID var id: String?
    var name = ""
    var hostName = ""
 var locationName = ""
    var address = ""
    var category = ""
    var summary = ""
    var description = ""
    var startDate = Date()
    var startTime = ""
    var endTime = ""
    var phoneNumber = ""
    var latitude = 0.0
    var longitude = 0.0
    var participants: [String] = []
    // this refer to here whenever we need a coordinate to refer to  
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var dictionary:[String:Any]{
        return ["name": name,"hostName" : hostName,"locationName":locationName,"address":address,"latitude": latitude,"longitude":longitude,"category" :category,"description" : description,"startDate" : Timestamp(date: Date ()),
                
                "startTime" : startTime,"endTime" : endTime,"phoneNumber" : phoneNumber,"summary" : summary
        ]
    }
}
