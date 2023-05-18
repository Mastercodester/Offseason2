//
//  AddStore.swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/15/23.
//


import CoreLocation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import MapKit
import SwiftUI


struct AddEvent: View {
    @State private var showPlaceLookupSheet = false

    @State var isPickerShowing = false

    @EnvironmentObject private var eventVm: EventViewModel
    @State var event: Event
    @Environment(\.dismiss) private var dismiss

    var body: some View {   
        NavigationStack{
            VStack{
                Form{
                
                    Section(header: Text("Event Details")) {
                        TextField("Event Name",text:$event.name)
                        TextField("Summary",text:$event.summary)
                        TextField("Description",text:$event.description)
                       
                        Button("Location"){
                            showPlaceLookupSheet.toggle()
                        }
                        TextField("Location Name",text:$event.locationName)

                        TextField("Address",text:$event.address)

                        
                        
                        
                        Button("Ticket Details"){
                            //TODO: ADD ANOTHER PAGE TO ADD HERE
                        }
                         
                     }
                    
                    
                    
                    
                    
                }
            }.toolbar{
                ToolbarItem(placement: .automatic) {
                    saveButton
                   
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back"){
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showPlaceLookupSheet) {
                PlaceLookupView(event: $event)
            }
            
        }
        
        
    }
}

struct AddEvent_Previews: PreviewProvider {
    static var previews: some View {
        AddEvent(event: Event())
        .environmentObject(EventViewModel())
        
    }
}





private extension AddEvent {
    var saveButton: some View{
        Button("Save"){
            Task{
                let success = await eventVm.saveEvent(event: event)
                if success {
                    dismiss()
                } else {
                    print("🤬 Error: Saving spot")
                }
            }
            
        }
    }
        // new code
    
    
    
    
}
