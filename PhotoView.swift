//
//  PhotoView.swift
//  Snacktacku;ar
//
//  Created by Jacquese Whitson  on 5/14/23.
//
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift
import SwiftUI
import MapKit
import PhotosUI
import WeatherKit


struct PhotoView: View {
    @EnvironmentObject private var eventVm: EventViewModel
    @Binding var photo : Photo
    var event: Event
    var player: Player
    var uiImage: UIImage


    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                Spacer()
                TextField("Description", text:$photo.description)
                    .textFieldStyle(.roundedBorder)
                // disbale this button if the current users amil doesnt match the email of who posted
                    .disabled(Auth.auth().currentUser?.email != photo.reviewer)
                Text("by:\(photo.reviewer) on: \(photo.postedOn.formatted(date: .numeric, time: .omitted))")
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .padding()
            .toolbar{// code here to show what button should be shown in the toolbar based on who posted it
                if Auth.auth().currentUser?.email == photo.reviewer {
                    // image was posted by current user
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                     
                    ToolbarItem(placement: .automatic) {
                        Button("Save"){
                    Task{
//        let success = try await eventVm.saveImage(event: event, photo: photo, image: uiImage)
                        
                        let success = try await eventVm.saveImage(player: player, event: event, photo: photo, image: uiImage)
                        
                                    if success {
                                        dismiss()
                                    }
                                }
                            
                            
                        }
                    }
                } else {
                // image was not posted by current user
                    ToolbarItem(placement: .automatic) {
                        Button("Done"){
                            dismiss()
                        }
                    }
                }
               
                
                
            }
            
        }
    }
}




struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        //binding vars should be constant in preview providers 
        PhotoView(photo: .constant(Photo()), event: Event(), player: Player(), uiImage: UIImage(named: "pizza") ?? UIImage() ).environmentObject(EventViewModel())
    }
}
