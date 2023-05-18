//
//  ExplorePage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI

struct ExplorePage: View {
    var body: some View {
        NavigationView
        { ZStack{
            List {
                Section(header: Text("Categories")){
                    
                    filterspage23()
                    
                }
                
                Section(header: Text("Near Me")){
                    ScrollView(.horizontal){ HStack{
                        Imagecard()
                        
                        Imagecard()
                    }
                        
                    }
                }.padding()
                
                Section(header: Text("Upcoming")){
                    
                    ScrollView(.horizontal){ HStack{
                        Imagecard()
                        
                        Imagecard()
                    }
                        
                    }
                    
                }
                
                .padding()
                
            }.headerProminence(.increased)
            
            
            
                .navigationTitle("Explore")
            
        }
            
            
            
            
            
        }
    }
    
    
}

struct ExplorePage_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePage()
    }
}



private extension ExplorePage {
    
    private struct Filters: Identifiable {
        var id: String {name}
        let name: String
        
    }
    
    struct filterspage23: View {
        private let filters: [Filters] = [
            Filters( name: "Baseball"),
            Filters( name: "Chess"),
            Filters( name: "Soccer"),
            Filters( name: "Football"),
            Filters( name: "Basketball"),
        ]
        
        
        
        
        var body: some View {
            ScrollView(.horizontal){
                HStack(spacing:20){
                    ForEach(filters) { filters in
                        Button{}label: {
                            Text(filters.name).font(.system(size: 15))
                        }
                        
                        
                        
                        
                    }.buttonStyle(.plain)
                        .padding()
                        .frame(width: .infinity)
                        .background(Color(.gray)).cornerRadius(90)
                }
            }
        }
    }
    
    
    struct Imagecard: View {
        var body: some View {
            VStack(alignment: .leading, spacing: 50) {
                Image("card")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 240, height:200)
                cardText
                    .padding(.horizontal, 0)
                }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 24.0))
                .shadow(radius: 8.0)
        }
    
    
        var cardText: some View {
            VStack(alignment: .leading, spacing:4.0){
                Text("Morning Workout").font(.headline)
                HStack(spacing:4.0){
                    Image(systemName: "clock.arrow.circlepath")
                    Text("10 min")
                }.foregroundColor(.gray)
            }.padding()
        }
    }
}
