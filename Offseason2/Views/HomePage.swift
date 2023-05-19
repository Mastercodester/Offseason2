//
//  HomePage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
import MapKit
import FirebaseFirestoreSwift
import PhotosUI
import WeatherKit

struct Home_Page: View {
    @State var event: Event
    @FirestoreQuery(collectionPath:"events") var events: [Event]

     
    
    // showing sheets
    @State var presentnotificationSheet = false
    @State var presentWeatherSheet = false
    @State var presentHelpSheet = false
    @State var presentfilterSheet = false
    @State var presentCreateSheet = false
    
    //for Map
    @State private var annotations: [Annotation] = []
//    @State private var mapRegion = MKCoordinateRegion()
    let regionSize = 500.0

    
    @StateObject private var weatherViewModel = WeatherViewModel()
    
     @EnvironmentObject private var locationVm : LocationManager
    @EnvironmentObject private var mapVm : MapViewModel
    @EnvironmentObject private var eventVm : EventViewModel


    var body: some View {
        NavigationView{
            ZStack{
                mapLayer
                VStack{
                    Spacer()
                    Spacer()
                    HStack {
                        FilterButton
                        Spacer()
                        Spacer()
                        CreateButton
                    }.padding()
                    
                }
            } .ignoresSafeArea()
            .toolbar{
                ToolbarItemGroup(placement: .cancellationAction) {
                    VStack{
                        NotificationButton
                        HelpButton
                    }
                    .padding(.top,70)
                
                }
                ToolbarItemGroup(placement: .primaryAction) {
                    
                    HStack(spacing: 30){
                        ActivegamesButton
                        WeatherButton
                         
                    }
                }
            }
            .onAppear {
                eventVm.allEvents = events
                mapVm.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationVm.location?.coordinate.longitude ?? 0.00, longitude: locationVm.location?.coordinate.latitude ?? 0.00), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            }
//            }.onAppear{
//
//
//
//
//                if event.id != nil { // if we have a spot center it on the map
//                    mapRegion = MKCoordinateRegion(center: event.coordinate, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
//                } else {// otherwise  center the map on the devices location
//                    Task {
//                        // make map region shows user lo
//                        mapRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
//                    }
//                }
//            }
            
        } .sheet(isPresented: self.$presentCreateSheet){
           AddEvent(event: Event())
                .presentationDetents([.medium, .large])
          }
        
        .sheet(isPresented: self.$presentfilterSheet){
            filterspage()
                .presentationDetents([.fraction(0.09)])
          }
        .sheet(isPresented: self.$presentHelpSheet){
          HelpPage()
              
          }
        
        .sheet(isPresented: self.$presentWeatherSheet){
         WeatherPage()
               
        }
        .sheet(isPresented: self.$presentnotificationSheet){
           NotificationPage()
            
        }
    }
}

struct Home_Page_Previews: PreviewProvider {
    static var previews: some View {
        Home_Page(event:Event())
            .environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(EventViewModel())



    }
}
























private extension Home_Page{
    var mapLayer : some View{
        Map(coordinateRegion: $mapVm.mapRegion,
            showsUserLocation: true,
            annotationItems:events,
            annotationContent:{
            event in
            MapAnnotation(coordinate: event.coordinate){
                LocationMapPin()
                    .scaleEffect(mapVm.eventLocation == event ? 1 : 0.7)
                     .onTapGesture{
                        mapVm.showNextEvent(event)
                    }
                
            }
        })
    }
    
    
    
    var NotificationButton:  some View {
        Button(action: { self.presentnotificationSheet.toggle() }) {
            Image(systemName: "bell.circle.fill").font(.system(size: 35))
                .foregroundColor(.blue)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
            
        }
        
    }
    
    var ActivegamesButton: some View {
        Button{
            
        }label: {
            HStack {
                Image(systemName: "figure.run.circle.fill")
                Text("Active:") .font(.title3)
                    .bold()
//                Spacer()

                Text("4")

            }
        }.buttonStyle(.plain)
            .padding()
            .frame(width: 160,height: 40)
            .background(.thinMaterial).cornerRadius(90)
            .shadow(color: Color.black.opacity (0.4), radius: 20,
                     x: 0, y: 15)
    }
    
    var WeatherButton: some View {
        Button{
            self.presentWeatherSheet.toggle()
        }label: {
            HStack{
                Image(systemName: "cloud")
                Text(weatherViewModel.currentTemperature.dropLast()).font(.system(size: 17))
                    .foregroundColor(.black)
            }.foregroundColor(.black)
                .buttonStyle(.plain)
                .padding()
                .frame(width: .infinity, height: 48)
                .background(.thinMaterial).cornerRadius(90)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
        }
//        Text(weatherViewModel.currentTemperature.dropLast())
//            .font(.system(size:72))
//            .fontWeight(.light)
        
    }
        
        
    var HelpButton: some View {
        Button{
            self.presentHelpSheet.toggle()
        }label: {
            ZStack{
                Circle()
                    .frame(width: 50, height: 45)
                    .foregroundColor(.red)

                Image(systemName: "cross.case").font(.system(size: 20))
//                    .fill(.ultraThinMaterial)
                    .foregroundColor(.white)
            }
             
        }.shadow(color: Color.black.opacity (0.4), radius: 20,
                 x: 0, y: 15)
    }
    var FilterButton: some View {
        Button{
            self.presentfilterSheet.toggle()
        }label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.system(size: 35)).foregroundColor(.black)
        }
    }
                
                var CreateButton: some View {
                    Button{
                        self.presentCreateSheet.toggle()
                    }label: {
                        Image(systemName: "plus.circle.fill").font(.system(size: 45)).foregroundColor(.black)
                    }
                
            
            
        
        
        
    }
    
}

