//
//  Player.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/21/23.
//
import Foundation
import FirebaseFirestoreSwift
import MapKit

 struct Player: Identifiable, Codable{
    @DocumentID var id : String?
    var name = ""
    var email : String
    var userName = ""
    var age = 0
}
