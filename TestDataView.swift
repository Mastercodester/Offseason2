//
//  TestDataView.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/18/23.
//


import SwiftUI
import MapKit
import Firebase
import FirebaseFirestoreSwift
import PhotosUI
import WeatherKit

struct TestDataView: View {
//    @FirestoreQuery(collectionPath:"events") var events: [Event]
    
    @FirestoreQuery(collectionPath: "events") var events : [Event]
    var body: some View {
        List(events) { event in
            Text(event.name)
        }    }
}

struct TestDataView_Previews: PreviewProvider {
    static var previews: some View {
        TestDataView()
    }
}
