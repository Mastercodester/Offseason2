//
//  EventSummaryCard.swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/29/23.
//

import SwiftUI
import CoreLocation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import MapKit
import SwiftUI
import FirebaseStorage 

struct EventSummaryCard: View {
    @EnvironmentObject private var vm: EventViewModel
  var event: Event
    var body: some View {
        VStack{
            // maybe a multitude of pics
            // TODO: this should be event.coverPhoto
            Image("sosa")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 113)
                .cornerRadius(21)
                .offset(y:-20)
    
            HStack{
                VStack{
                    Text(event.name )
                        .font(.system(size: 25))
                        .offset(y:-10)
                        .bold()
                    HStack{
                        Image(systemName: "calendar")
                        Text("\(event.startDate)")
                            .lineLimit(1)
                        Text("✘12:00 PM")
                    }
                    .font(.system(size: 25))

                    HStack(spacing:1){
                        Image(systemName: "mappin")
                            .foregroundColor(.gray)
                        Text(event.address)
                    } .font(.system(size: 25))
//                        .offset(y:13)

                    .padding(.trailing,10)
                }
                .overlay(
                    Text("$50")
            .font(.system(size: 25))
            .offset(x:140,y:30)
            .bold()
)
            }            .offset(y:-20)

            .padding()
            .background{
                ZStack{
                    RoundedRectangle(cornerRadius: 21)
                        .stroke(Color(red: 0.545, green: 0.545, blue: 0.588))
                        .frame(width: 350, height: 100)
                        .offset(y:-25)
                    
                    
                    RoundedRectangle(cornerRadius: 21)
                        .fill(.ultraThinMaterial )
                        .frame(width: 350, height: 100)
                        

                        .offset(y:-25)
                    

                    
                }
//                
//                RoundedRectangle(cornerRadius: 10)
//                .fill (.red)
//                .frame(width: 333, height: 125)
            }
            .offset(y:15)
        }
        .background{
//            RoundedRectangle(cornerRadius: 21)
//            .fill (.blue)
//            .frame(width: 370, height: 303)
            
            
            RoundedRectangle(cornerRadius: 21)
                .fill(LinearGradient(gradient: Gradient(colors: [Color("purp"), Color("wok")]), startPoint: .topLeading, endPoint: .bottom) )
                .frame(width: 376, height: 217)
            
            
            
            
            
            
            
            
          }
        .overlay{
            Button{
                //Todo: Alow discard event
            }
        label:{
            Image(systemName: "x.circle.fill")
                .offset(x: 170, y: -145)
                .font(.system(size: 48))
                .foregroundColor(.black)
        }
            
        }
        
 
    }
}

struct EventSummaryCard__Previews: PreviewProvider {
    static var previews: some View {
        EventSummaryCard(event:Event( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0)
                                )
            .environmentObject(EventViewModel())

    }
}
