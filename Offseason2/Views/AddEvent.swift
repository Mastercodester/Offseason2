//
//  AddStore.swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/15/23.
//


import CoreLocation
import FirebaseCore
import FirebaseFirestoreSwift
import FirebaseDatabase
import MapKit
import SwiftUI


struct AddEvent: View {
    @State private var showPlaceLookupSheet = false

    @State var isPickerShowing = false
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    @EnvironmentObject private var eventVm: EventViewModel
    @State var event: Event
    @Environment(\.dismiss) private var dismiss
    @FirestoreQuery(collectionPath: "events") var events : [Event]
//    42.33157
//    -83.045839
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.331578, longitude: -83.045839), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @EnvironmentObject private var locationVm : LocationManager
   
//    (locationVm.location?.coordinate.latitude ?? 0.00),\(locationVm.location?.coordinate.longitude ?? 0.00)")

    var body: some View {   
        NavigationStack{
            VStack{
                Form{
                    
                    Section(header: Text("Event Details")) {
                        TextField("Event Name",text:$event.name)
                        TextField("Summary",text:$event.summary)
                        TextField("Description",text:$event.description)
                        
                        Button("Location"){
                            showPlaceLookupSheet.toggle()
                        }
                        TextField("Location Name",text:$event.locationName)
                        
                        TextField("Address",text:$event.address)
                        
                        
                        
                        
                        Button("Ticket Details"){
                            //TODO: ADD ANOTHER PAGE TO ADD HERE
                        }
                        
                    }
                    
                    
                    
                    
                    
                }
                //                List(events) { event in
                //                    Text(event.name)
                //                }
//                Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:events){
//                    annotation in
//                    MapMarker(coordinate: annotation.coordinate)
//                }.frame(height: 290)
//                
                
            }
//            }.onAppear {
//                mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationVm.location?.coordinate.longitude ?? 0.00, longitude: locationVm.location?.coordinate.latitude ?? 0.00), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
//            }
            .toolbar{
                ToolbarItem(placement: .automatic) {
                    saveButton
                   
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back"){
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showPlaceLookupSheet) {
                PlaceLookupView(event: $event)
            }
            
        }
        
        
    }
}

struct AddEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddEvent(event: Event())
        .environmentObject(EventViewModel())
        .environmentObject(LocationManager())

        
    }
}





private extension AddEvent {
    var saveButton: some View{
        Button("Save"){
            Task{
                let success = await eventVm.saveEvent(event: event)
                if success {
                    dismiss()
                } else {
                    print("🤬 Error: Saving spot")
                }
            }
            
        }
    }
        // new code
    
    
    
    
}
