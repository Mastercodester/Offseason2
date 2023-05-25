//
//  AddToCart.swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/30/23.
//

import SwiftUI
import CoreLocation
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

import FirebaseDatabase
import MapKit
import SwiftUI
import FirebaseStorage

struct AddToCart: View {

@FirestoreQuery(collectionPath: "players") var events : [Event]

    @EnvironmentObject private var vm : EventViewModel
    var body: some View {
        ScrollView{
            VStack{
                ForEach(events,id:\.id){ event in
                    AddingCardsToCart(event: event)
                }
            }
        }
    }
}

struct AddToCart_Previews: PreviewProvider {
    static var previews: some View {
       AddToCart()
        .environmentObject(EventViewModel())
    }
}
