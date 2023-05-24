//
//  La Fitness Sheets.swift
//  OffSeason Tab
//
//  Created by Rheyya Hollins on 5/18/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit

struct GameDetailsView: View {
    // put in own file
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var locationVm : LocationManager
    @EnvironmentObject private var mapVm : MapViewModel
    @EnvironmentObject private var eventVm : EventViewModel
    @State var event: Event
    @State var player: Player

    @FirestoreQuery(collectionPath: "players") var events : [Event]
    @FirestoreQuery(collectionPath:"players") var photos: [Photo]

    enum Choices: String, CaseIterable {
        case directions = "", paper = "💵", scissors = "✂️"
    }
    
    
    var body: some View {
        NavigationStack {
            
                ZStack {
        ScrollView{
                    VStack {
                        eventName
                        VStack(alignment:.leading){
                            locationName
                            startDate
                             hostName
                    
                            VStack(spacing: 20) {
                                HStack(spacing:25){
                                    directionsButton
                                    hoursButton
                                    moneyButton
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                Divider()
                                
                                // images here
//
                                SpotDetailPhotosScrollView(photos: photos, event: event, player: player)

                                ScrollView(.horizontal) {
                                    HStack{
                                        Image("wtm")
                                            .resizable()
                                            .scaledToFill ()
                                            .frame(width: 120, height:120)
                                            .clipped()
                                        
                                        Image("wtm")
                                            .resizable()
                                            .scaledToFill ()
                                            .frame(width: 120, height:120)
                                            .clipped()
                                        
                                        Image("wtm")
                                            .resizable()
                                            .scaledToFill ()
                                            .frame(width: 120, height:120)
                                            .clipped()
                                        Image("wtm")
                                            .resizable()
                                            .scaledToFill ()
                                            .frame(width: 120, height:120)
                                            .clipped()
                                        
                                        
                                    }
                                }
                                .cornerRadius(20)
                            }
                            
                    
                            Text("Details")
                                .bold()
                                .font(.title)
                                Divider()
                            
                            Text(event.description)
                            .padding()
                            .frame(width: 360,alignment: .topLeading)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                                
                            
                            Text("Good To Know")
                                .bold()
                                .font(.title)
                            Divider()
                            //TODO: GOOD TO KNOW FORM
                            Text(event.description)
                            .padding()
                            .frame(width: 360,alignment: .topLeading)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                            
                
                        }.padding(.leading)
                        
                        VStack{
                            Text("Ratings & Reviews")
                                .bold()
                                .font(.title)
                            Divider()

                            Text("ok")
                            .padding()
                            .frame(width: 360, height: 250,alignment: .topLeading)
                            .background(.ultraThinMaterial)
                            .cornerRadius(20)
                        }
                           
                    }
                    .toolbar{
                ToolbarItemGroup(placement: .confirmationAction) {
                          favoriteButton
                            xButton
                            }
                    }
                    
                    
                    
                   
                        
                }
                //                .padding()
              
                ZStack{
                    
                    VStack {
                    
                    Spacer()
                    Button{}
                label:{
                    Text("Join Game")
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .frame(width: 350, height: 70)
                        .background(.orange)
                        .clipShape(Capsule())
                    
                }
                }
            }
            }
            
       }
    }
}


    struct LaFitness: PreviewProvider {
        static var previews: some View {
            GameDetailsView(event: Event( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0), player: Player())
                .environmentObject(LocationManager())
                .environmentObject(MapViewModel())
                .environmentObject(EventViewModel())
                .environmentObject(WeatherViewModel())
        }
    }
































private extension GameDetailsView {
    var directionsButton: some View {
        // new code⚡️
        Button{
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "car")
                    .font(.title)
            }
        }
    }
    // new code⚡️
    var hoursButton: some View {
        // new code⚡️
        Button{
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "clock")
                    .font(.system(size: 25))
                    .font(.title)
            }
        }
    }
    
    
    // new code⚡️
    var moneyButton: some View {
        // new code⚡️
        Button{
            presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack{
        RoundedRectangle(cornerRadius: 30)
                    .fill(.black)
                    .frame(width: 92, height: 32)

                Image(systemName: "dollarsign")
                    .font(.body)
            }
        }
    }
    
    
    // new code⚡️
    var favoriteButton : some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "heart")
                .foregroundColor(.red)
                .font(.title)
            
        })
    }
    
    
    
    // new code⚡️
    var xButton : some View  {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.gray)
                .font(.title)
            
    })
    }
    
    
    
    // new code⚡️
    var locationName : some View {
        HStack{
            Image(systemName: "mappin")   .foregroundColor(.black)
            
                .font(.system(size: 20))
            
            Text(event.locationName)
                .lineLimit(1)
                .font(.title2)
                .bold()
        }        .font(.system(size: 20))
            .foregroundColor(.gray)
    }
    
    // new code⚡️
    var startDate : some View {
        HStack{
            Image(systemName: "calendar")                                    .foregroundColor(.black)
            
            Text( "on: \(event.startDate.formatted(date: .numeric, time: .omitted))")
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            //                                    .font(.title2)
        } .foregroundColor(.gray)
        
            .font(.system(size: 20))
    }
    
    // new code⚡️
    var hostName : some View {
        HStack{
            Image(systemName: "person")
                .foregroundColor(.black)
            
            //TODO: maybe change this to the player.name
            Text("Hosted By: \(event.hostName)")
        }.padding(.bottom)
            .bold()
            .foregroundColor(.gray)
            .font(.system(size: 20))
    }
    
    // new code⚡️
    var eventName : some View {
        Text(event.name)
            .lineLimit(1)
            .bold()
            .font(.title)
    }
    
    // new code⚡️

    
    // new code⚡️

    
    // new code⚡️

    
    
    // new code⚡️

    
    
    
    // new code⚡️

    
    
    // new code⚡️

    
    
    // new code⚡️

    
    
}
