//
//  La Fitness Sheets.swift
//  OffSeason Tab
//
//  Created by Rheyya Hollins on 5/18/23.
//

import SwiftUI

struct SecondScreen: View {
    // put in own file
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                
                VStack(alignment:.leading){
                    HStack{
                        Image(systemName: "mappin")
                        Text("LA Fitness")
                            .font(.largeTitle)
                    }
                    HStack{
                        Image(systemName: "calendar")
                        Text("May 25th, 2023")
                            .font(.title2)
                    }
                    HStack{
                        Image(systemName: "person")
                        Text("Hosted By: Jamal Adams")
                    }.padding(.bottom)
                    
                    HStack{
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "car")
                                .foregroundColor(.gray)
                                .font(.title)
                            
                        })
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                                .font(.title)
                            
                        })
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "dollarsign")
                                .foregroundColor(.gray)
                                .font(.title)
                            
                        })
                    }.padding(.horizontal)
                    
                    
                    ScrollView(.horizontal) {
                        HStack {  Image("Bitmap2")
                                .resizable()
                            //                    .scaledToFit()
                            //                    .scaledToFill()
                                .frame(width: 200, height: 200)
                            Image("Bitmap")
                                .resizable()
                                .frame(width: 200, height: 200)
                            Image("Bitmap3")
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                    }
                    ScrollView{
                        Text("Details")
                            .font(.title)
                        Text("This is a pickup game. We are playing 4 v 4 so make sure you have your squad with you or find other people to play with. Ages 18+ please. Best out of 3 receives street cred")
                            .padding(.bottom)
                        Text("Good To Know")
                            .font(.title)
                        Text("Hours: 8am-8pm")
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 350, height: 200)
                            .background(Rectangle().fill(Color.white).shadow(radius: 3))
                        Text("Ratings & Reviews")
                            .font(.title)
                    }.padding(.leading)
                    
                }.toolbar{
                    ToolbarItemGroup(placement: .confirmationAction) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                                .font(.title)
                            
                        })
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.title)
                            
                        })
                        
                    }
                    
                }
                
                //
            }
        }
    }
    
    struct LaFitness: PreviewProvider {
        static var previews: some View {
            SecondScreen()
        }
    }
}
