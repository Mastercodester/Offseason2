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
    @State private var mapRegion = MKCoordinateRegion()
    let regionSize = 500.0


    
    @StateObject private var weatherViewModel = WeatherViewModel()
    
     @EnvironmentObject private var locationVm : LocationManager
    
    var body: some View {
        NavigationView{
            ZStack{
                
                
                List(events){ event in
                    Text(event.name)
                }
//                Map(coordinateRegion: $locationVm.region,showsUserLocation: true, annotationItems:events){
//                    annotation in
//                    MapMarker(coordinate: annotation.coordinate)
//                }.ignoresSafeArea()
//                    .onChange(of:event){ _ in
//                        annotations = [Annotation(name: event.name, address: event.address, coordinate: event.coordinate)]
//                        mapRegion.center = event.coordinate
                   // }
//            Color.teal.ignoresSafeArea()
            VStack{
                HStack {
                   NotificationButton
                    Spacer()
                ActivegamesButton
                        Spacer()
                    WeatherButton
                   
                }.padding()
                
                
                HStack {
                    HelpButton
                   
                    
                    Spacer()
                
                    Spacer()
                   
                }.padding()
              Spacer()
                Spacer()
                Text("Location: \n\(locationVm.location?.coordinate.latitude ?? 0.00),\(locationVm.location?.coordinate.longitude ?? 0.00)")

                HStack {
                    FilterButton
                    
                   
                    Spacer()
                
                    Spacer()
                    
                    CreateButton
                    
                    
                }.padding()
               
            }
          
            }.onAppear{
                
                
                
                
                if event.id != nil { // if we have a spot center it on the map
                    mapRegion = MKCoordinateRegion(center: event.coordinate, latitudinalMeters: regionSize, longitudinalMeters: regionSize)
                } else {// otherwise  center the map on the devices location
                    Task {
                        // make map region shows user lo
                        mapRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
                    }
                }
            }
            
        } .sheet(isPresented: self.$presentCreateSheet){
           CreateGameForm()
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

    }
}
























private extension Home_Page{
    
    var NotificationButton:  some View {
        Button(action: { self.presentnotificationSheet.toggle() }) {
            Image(systemName: "bell.circle.fill").font(.system(size: 35)) .font(.system(size:(20)))
                .foregroundColor(.black)
            
        }
        
    }
    
    var ActivegamesButton: some View {
        Button{
            
        }label: {
            HStack {
                Image(systemName: "figure.run.circle.fill")
                Text("Active: 8") .font(.system(size:(20)))
            }
        }.buttonStyle(.plain)
            .padding()
            .frame(width: 160)
            .background(Color(.gray)).cornerRadius(90)
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
                .background(Color(.gray)).cornerRadius(90)
        }
//        Text(weatherViewModel.currentTemperature.dropLast())
//            .font(.system(size:72))
//            .fontWeight(.light)
        
    }
        
        
    var HelpButton: some View {
        Button{
            self.presentHelpSheet.toggle()
        }label: {
            Image(systemName: "checkerboard.shield").font(.system(size: 35))
                .foregroundColor(.black)
            
        }
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

