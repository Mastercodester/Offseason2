//
//  filterspage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
private struct Filters: Identifiable {
    var id: String {name}
    let name: String
    
}

struct filterspage: View {
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

struct filterspage_Previews: PreviewProvider {
    static var previews: some View {
        filterspage()
    }
}
