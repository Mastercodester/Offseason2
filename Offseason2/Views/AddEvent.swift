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
    @State private var annotations: [Annotation] = []
    @State private var showMap = false
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
        
        ScrollView {
            ZStack {
                VStack{
                    coverPhoto
                   Spacer()
                    VStack{
                                            Section(header: Text("Customize Your Game ")
                                                .bold()
                                                .font(.title)) {
                                                    VStack{
                                                        TextField("Event Name",text:$event.name)
                                                            .textFieldStyle (.roundedBorder)
                                                                .overlay {
                                                                RoundedRectangle (cornerRadius: 5)
                                                                .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                            }
                                                        TextField("Summary",text:$event.summary)
                                                            .textFieldStyle (.roundedBorder)
                                                                .overlay {
                                                                RoundedRectangle (cornerRadius: 5)
                                                                .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                            }
                                                        TextField("Description",text:$event.description)
                                                            .textFieldStyle (.roundedBorder)
                                                                .overlay {
                                                                RoundedRectangle (cornerRadius: 5)
                                                                .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                            }
                                                    Button("Location"){
                                        showPlaceLookupSheet.toggle()
                                            showMap.toggle()

                                                        }.frame(width: 360,height:40)
                                                        .textFieldStyle (.roundedBorder)
                                                            .overlay {
                                                            RoundedRectangle (cornerRadius: 5)
                                                            .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                        }
                                                        // if the text field is no longer empty
                                                       
                                                        if !event.locationName.isEmpty && !event.address.isEmpty {
                                                        TextField("Location Name",text:$event.locationName).disabled(true)
                                                            .textFieldStyle (.roundedBorder)
                                                                .overlay {
                                                                RoundedRectangle (cornerRadius: 5)
                                                                .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                            }
                                                        
                                                        TextField("Address",text:$event.address).disabled(true)
                                                            .textFieldStyle (.roundedBorder)
                                                                .overlay {
                                                                RoundedRectangle (cornerRadius: 5)
                                                                .stroke(.gray.opacity(0.5), lineWidth: event.id == nil ? 2 : 0)
                                                            }
                                                        
                                                        
                                                        
                                                      Text("Confirm your location is correct")
                                                                .bold()
                                                                .font(.title2)
                                                            Map(coordinateRegion: $mapRegion,showsUserLocation: true, annotationItems:annotations){
                                                                annotation in
                                                                MapMarker(coordinate: annotation.coordinate)
                                                            }
                                                            .cornerRadius(20).frame(height: 250)
                                                            
                                                                .onChange(of:event){ _ in
                                                                    annotations = [Annotation(name: event.name, address: event.address, coordinate: event.coordinate)]
                                                                    mapRegion.center = event.coordinate
                                                                }
                                                        }
                                                        Button("Ticket Details"){
                                                            //TODO: ADD ANOTHER PAGE TO ADD HERE
                                                        }
                                                    }
                                                    
                                            }
                                    .padding(.horizontal)
                                  Spacer()
                                        }
                    
                }
            }
        //
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
    var coverPhoto : some View {
        Image ("wtm")
            .resizable()
            .scaledToFill()
            .frame(width:350,height: 240)
            .cornerRadius(10)
            .clipped()
            .overlay(
                HStack{
                    Button{}
                label:{
                    Image(systemName: "photo")
                    Text("Cover Photos")
                }
                }
                    .foregroundColor(.black)
                    .padding()
                    .background(.orange)
                    .cornerRadius(20))
    }
    
    // new code

    
    
}
