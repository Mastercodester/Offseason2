//
//  EventPlaceViewModel.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/18/23.
//

import Foundation
import MapKit

@MainActor
class EventPlaceViewModel : ObservableObject {
    @Published var places : [EventPlace] = []
    
    
    // func alllows us to get all the data of the address typed in
    func search(text:String,region: MKCoordinateRegion){
        let searchRequest = MKLocalSearch.Request()
        // this allows for suggested things to pop uo based on what we type ↓
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        let search = MKLocalSearch(request: searchRequest)
        
        search.start{
            response, error in
            guard let response = response else {
                print("🤬Error: \(error?.localizedDescription)")
                return
            }
            self.places = response.mapItems.map(EventPlace.init)
        }
    }
}


