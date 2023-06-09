//
//  File.swift
//  Snacktacku;ar
//
//  Created by Jacquese Whitson  on 4/25/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

import UIKit
import FirebaseStorage

// this is beacuse we ere going to be updating the ui from this page  so we need to make sure its in the main thread
@MainActor
class EventViewModel: ObservableObject {
    @Published var event = Event()
    @Published var player = Player()
    
    
    @Published var selectedEvent: Event? = nil
   
    var allEvents:[Event] = []

    //TODO: create type Player
    // this should be a path in firebase 
    var joinedPlayers:[Event] = []

    
    func joinEvent(player:Player, event:Event) -> Bool {
        guard let playerID = player.id else {
            return false
        }
        guard let eventID = event.id else {
            return false
        }
        
        //ths is a changeble var
        var joinedPlayers = event
        joinedPlayers.participants.append(playerID)
        return true
         
        
    }
    
    
     
    func addEvent(event: Event) {
        allEvents.append(event)
        //
    }
    
    
    func savePlayer(player:Player) async -> Bool{
        let db = Firestore.firestore()
        if let id = player.id { // update the data that alrsady here
        do {
            try await db.collection("players").document(id).setData (player.dictionary)
        print ("😎 Data updated successfully!")
        return true
        } catch {
        print ("🤬ERROR: Could not update data in'spots'")
           return false
        }
        } else {
            // add data to firestore
            do{
                
        let documentRef = try await db.collection("players").addDocument(data: player.dictionary)
            // this is to make sure we are updating the the 'spot' on xcode when a new value is inputed, so thay we have a id before its in fb
                self.player = player
                
                self.player.id = documentRef.documentID
                print("😎 Data added succesfully ")
                return true
            } catch{
                print("🤬Error: could not add data")
                return false
                
            }
        }
    }
    
    
    
    
    func saveEvent(player:Player,event:Event) async -> Bool{
        let db = Firestore.firestore()
        // this is to make suree we have an spot id
        guard let playerID = player.id else {
            print ("🤬ERROR: Could not get player id '")
            return false
        }
        
        // this is the path that we are storing the reviews to
        let collectinString = "players/\(playerID)/events"
        if let id = event.id { // update the data that alrsady here
            do {
                try await db.collection(collectinString).document(id).setData(event.dictionary)
                print ("😎 Data updated successfully!")
                return true
            } catch {
                print ("🤬ERROR: Could not update data in'events \(error.localizedDescription)")
                return false
            }
        } else {
            // add data to firestore
            do{
              _ = try await db.collection(collectinString).addDocument(data: event.dictionary)
                print("😎 Data added succesfully ")
                return true
            } catch {
                print("🤬Error: could not create new review in 'reviews' \(error.localizedDescription)")
                return false
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    func saveImage(player:Player,event: Event,photo: Photo,image: UIImage) async -> Bool {
       
        guard let playerID = player.id else {
            print("🤬 ERROR: player ID == nil")

            return false
        }
        
        guard let eventID = event.id else {
            print("🤬 ERROR: event ID == nil")

            return false
        }

        var  photoName = UUID().uuidString
            if photo.id != nil  {// if i have a photo id use the name of the photo id instead of creating a new one, we'll use this so we can update the description of a photo without resaving the photo
                photoName = photo.id!
                }
        let storage = Storage.storage()
    
    // TODO: UPDATE PATHS
        let storageRef = storage.reference().child("\(playerID)/\(eventID)/\(photoName).jpeg")

        // compressing image
        guard let resizedImage = image.jpegData(compressionQuality: 0.2) else {
            print("🤬 ERROR: could not resize image")
            return false
        }

        let metadata = StorageMetadata()
        // Allowds us to dispaly the image in the storgae database
        metadata.contentType = "image/jpg"

    // this will hold the url of the image that we saved
        var imageURLString = ""

        do {
            // adding the image data to storage (resized, metadata)
    let _ = try await storageRef.putDataAsync(resizedImage,metadata: metadata)
            print("😎 image saved")
            do {
    // gettin the pictures url from storage
    let imageURL = try await storageRef.downloadURL()
//turning URL into a string so i can use it to access/ create new path for spot
                imageURLString = "\(imageURL)"
            }catch{
                print("🤬 ERROR: could not get imageUrl after saving image")
                return false
            }
        }
        catch {
            print("🤬 ERROR: Uploading image to firebase")
            return false
        }



        // Saving Photos to database,
        let db = Firestore.firestore()
        //Creating paths for photos to go
        let collectionString  = "players/\(playerID)/events/\(eventID)/photos"
        do {//
            var newPhoto = photo
            //allows us to display the image
            newPhoto.imageUrlString = imageURLString

    // updating the database with the meta data of the photo
    // instead of using the .addDocument func use the .document() and plug in the document we already have
    // this way you are updating the document that already exists instead of creating  a new one
try await

            db.collection(collectionString).document(photoName).setData(newPhoto.dictionary)
            print("😎 Data updated successfully")
            return true
        }catch{
            print("🤬 ERROR: Could not updte dat in 'photos for spot id")
            return false
        }

    } // end func
        
    
}// class
