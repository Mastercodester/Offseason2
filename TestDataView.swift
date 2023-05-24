//
//  TestDataView.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/18/23.
//


import SwiftUI
import MapKit
import Firebase
import FirebaseFirestoreSwift
import PhotosUI
import WeatherKit

struct TestDataView: View {
//    @FirestoreQuery(collectionPath:"events") var events: [Event]
    
    @FirestoreQuery(collectionPath: "players") var events : [Event]
    @FirestoreQuery(collectionPath:"players") var photos: [Photo]

    //images
    @State private var selectedPhoto : PhotosPickerItem?
    @State private var uiImageSelected = UIImage()
    @State var newPhoto =  Photo()
    
    var previewRunning = false
    @State private var showPhotoSheet = false
    @State private var showSaveAlert = false
    @State private var  showReviewViewSHeet = false
    @State private var showPlaceLookupSheet = false
    @State var event: Event
    @State var player: Player

    @EnvironmentObject var eventVm : EventViewModel
    var body: some View {
        VStack{
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic){
                Image(systemName: "photo")
                Text ("Photo" )
                
            }
            
            Text ("Photos")
                  
                  
            SpotDetailPhotosScrollView(photos: photos, event: event, player: player)
        }
        .onAppear{
            if !previewRunning  && event.id != nil {
                
        $photos.path = "players/\(player.id ?? "")/events/\(event.id ?? "")/photos"
                
//                $photos.path = "spots/\(spot.id ?? "")/photos"

                print("photos.path = \($photos.path)")
            }
        }
        
        .onChange(of: selectedPhoto){ newValue in
            Task{
                do{
                    if let data = try await newValue?.loadTransferable(type: Data.self){
                        
                        if let uiImage = UIImage(data: data){
            // passsing off the uiImage that is loaded into here into a different var so we can use it in other places
                            uiImageSelected = uiImage
                            print("📸Succcesffullly selected image")
                            newPhoto = Photo()
                            // clears out contents if you add more than 1 photo in a row for this spot

// use this because if there is no spot we need to save the spot first then continue with the action we just pressed
//
                            //if event.id == nil {
//                                showSaveAlert.toggle()
//                            } else {
//                            }
//
                            showPhotoSheet.toggle()

                            
                        }
                        
                    }
                } catch {
                    print("🤬Error Selecting Image failed \(error.localizedDescription)")
                }
            }
        }
        .sheet(isPresented: $showPhotoSheet) {
            NavigationStack{
                PhotoView(photo:$newPhoto,event:event, player: player, uiImage:uiImageSelected)
            }
            
            
           
        }
         
    }
}

struct TestDataView_Previews: PreviewProvider {
    static var previews: some View {
        TestDataView(previewRunning: true, event: Event(), player: Player())
            .environmentObject(EventViewModel())
    }
}
