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
    @State var player: Player

    @FirestoreQuery(collectionPath:"players") var events: [Event]

     
    
    // showing sheets
    @State var presentnotificationSheet = false
    @State var presentWeatherSheet = false
    @State var presentHelpSheet = false
    @State var presentfilterSheet = false
    @State var presentCreateSheet = false
    @State var myRegion = MKCoordinateRegion()

    //for Map
    @State private var annotations: [Annotation] = []
//    @State private var mapRegion = MKCoordinateRegion()
    let regionSize = 500.0

    
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    
     @EnvironmentObject private var locationVm : LocationManager
    @EnvironmentObject private var mapVm : MapViewModel
    @EnvironmentObject private var eventVm : EventViewModel

//    @State var player: Player
    var body: some View {
        NavigationView{
            ZStack{
                mapLayer
            } .ignoresSafeArea()
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar) {
                        VStack {
                            HStack(spacing: 12){
                                FilterButton
                                Spacer()
                                CreateButton
                                    .offset(x:20,y:-20)
                            }.padding(.bottom,30)
                        }
                    }
                    ToolbarItemGroup(placement: .cancellationAction) {
                        VStack{
                            NotificationButton
                            HelpButton
                        }
                        .padding(.top,60)
                        
                    }
                    ToolbarItemGroup(placement: .primaryAction) {
                        HStack(spacing: 2){
                            ActivegamesButton
                            WeatherButton
                            
                        }
                    }
                }
                .task {
                    // make map region shows user lo
                    myRegion = MKCoordinateRegion(center: locationVm.location?.coordinate  ?? CLLocationCoordinate2D(), latitudinalMeters: regionSize, longitudinalMeters: regionSize)
                }
                .onAppear {
                    
                    eventVm.allEvents = events
                    
                    $events.path = "players/\(eventVm.player.id ?? "")/events"
                    
                    eventVm.allEvents = events
                    //                mapVm.mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationVm.location?.coordinate.longitude ?? 0.00, longitude: locationVm.location?.coordinate.latitude ?? 0.00), span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                }
            
        }
        .sheet(item: $eventVm.selectedEvent){
            event in
            GameDetailsView(event: event, player: player)
        }

        
        .sheet(isPresented: self.$presentCreateSheet){
            AddEvent(event: Event())

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
        Home_Page(event:Event(), player: Player())
            .environmentObject(LocationManager())
            .environmentObject(MapViewModel())
            .environmentObject(EventViewModel())
            .environmentObject(WeatherViewModel())




    }
}
























private extension Home_Page{
    // new code ⚡️
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
                         eventVm.selectedEvent = event

                        mapVm.showNextEvent(event)
                    }
                
            }
        })
    }
    
    
    // new code ⚡️
    var NotificationButton:  some View {
        Button(action: { self.presentnotificationSheet.toggle() }) {
            Image(systemName: "bell.circle.fill").font(.system(size: 35))
                .foregroundColor(.blue)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
            
        }
        
    }
    // new code ⚡️
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
    
    // new code ⚡️
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
                .frame(width: .infinity, height: 40)
                .background(.thinMaterial).cornerRadius(90)
                .shadow(color: Color.black.opacity (0.4), radius: 20,
                         x: 0, y: 15)
        }
//        Text(weatherViewModel.currentTemperature.dropLast())
//            .font(.system(size:72))
//            .fontWeight(.light)
        
    }
        
    // new code ⚡️
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
    
    // new code ⚡️
    var FilterButton: some View {
        Button{
            self.presentfilterSheet.toggle()
        }label: {
            Image(systemName: "line.3.horizontal.decrease.circle.fill").font(.system(size: 35)).foregroundColor(.black)
        }
    }
                // new code ⚡️
        var CreateButton: some View {
            Button{
                        self.presentCreateSheet.toggle()
                    }label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50)).foregroundColor(.red)
                            .shadow(color: Color.black.opacity (0.4), radius: 20,
                                     x: 0, y: 15)
                    }
//                    .offset(y:-25
//                    )
                
            
            
        
        
        
    }
    
}

