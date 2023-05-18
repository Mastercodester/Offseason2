//
//  Annotation.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/18/23.
//

import Foundation
import SwiftUI
import MapKit
import FirebaseFirestoreSwift
import PhotosUI

struct Annotation : Identifiable{
    let id = UUID().uuidString
    var name : String
    var address : String
    var coordinate : CLLocationCoordinate2D
}
