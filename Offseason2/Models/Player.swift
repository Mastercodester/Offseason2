//
//  Player.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/21/23.
//
import Foundation
import Firebase
import FirebaseFirestoreSwift
import MapKit

 struct Player: Identifiable, Codable,Equatable{
    @DocumentID var id : String?
    var name = ""
    var email = ""
    var userName = ""
    var age = 0
     
     var dictionary:[String:Any]{
         return  [
            "name" : name, "email": email,"userName": userName,"age": age
         
         ]
     }
}
