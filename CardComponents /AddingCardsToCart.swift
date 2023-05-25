//
//  AddingCardsToCart.swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/30/23.
//
import CoreLocation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import MapKit
import SwiftUI
import FirebaseStorage

struct AddingCardsToCart: View {
    @EnvironmentObject private var vm : EventViewModel
    var event: Event
    @State var ticketCount = 0
    var body: some View {
        VStack {
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
                    //TODO: usin enum type to display whats getting show here
                    VStack(alignment: .center){
                        Text("General")
                            .font(.system(size: 15))
                        Text("Admission")
                            .font(.system(size: 15))
                        Text("$50")
                            .font(.system(size: 40))

                    }
                    .padding(.leading)
                    .frame(maxWidth:.infinity,alignment: .leading)

                    Text("\(event.name )")
                        .offset(x:-90,y:-30)
                        .font(.system(size: 20))
                        .bold()
                    
                    
                }
                .padding()
                .foregroundColor(Color("lsu"))
                .background{
                    ZStack{
                        RoundedRectangle(cornerRadius: 21)
                            .fill (.ultraThinMaterial)
                            .frame(width: 350, height: 100)
                        step
                            .offset(y:14)
                    }
                }   .offset(y:-14)
                    .overlay(
                        RoundedRectangle(cornerRadius: 21)
                    .stroke(Color(red: 0.545, green: 0.545, blue: 0.588))
                        .frame(width: 350, height: 100)
                        .offset(y:-14)

                    )
                
                Text("*All purchases are final")
                    .font(.system(size: 15))
                    .offset(y:-47)
            }
            .background{
                RoundedRectangle(cornerRadius: 21)
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("purp"), Color("wok")]), startPoint: .topLeading, endPoint: .bottom) )
                    .frame(width: 376, height: 217)
            }
            
            
          
            
        }
        
    }
    
    
    var step : some View {
        HStack{
            Button(){
                if ticketCount >= 1{
                    ticketCount -= 1
                }
            } label:{
                Image(systemName: "minus")
                    .foregroundColor(.black)
                    .frame(width: 1, height: 1)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            }
            
            Text("\(ticketCount)")
                .font(.system(size: 30))
                .foregroundColor(ticketCount >= 1 ?  Color("slime") : Color.black )
            Button(){
                ticketCount += 1
              } label:{
                Image(systemName: "plus")
                      .font(.system(size: 15))
                    .foregroundColor(.black)
                    .frame(width: 1, height: 1)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)


            }
            
        }.bold()
            .offset(x:110)
        
        
    }
    
}

struct AddingCardsToCart_Previews: PreviewProvider {
    static var previews: some View {
        AddingCardsToCart(event: Event( name: "Test Run", hostName: "Mike.F", locationName: "LA Fitness", address: "660 Woodward ", category: "BAsketball", summary: "MY kickback come turnuo", description: "This is a pickup game. we are playing 4v4 so make sure yiu have your sqaud with you or find other people to play with spns[dib[sehin]ofewinf]oief]oiwehnf]owhenf]oihwnefoije'ofje]ofj]oefj]eoifh]oeifj[owefjho[weijio]ewhjoiefhjehiw", startDate: Date(), startTime: "12.pm", endTime: "1am`", phoneNumber: "313-472-3545", latitude: 0.0, longitude: 0.0))            .environmentObject(EventViewModel())

    }
}


