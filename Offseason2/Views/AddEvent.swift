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


struct AddStore: View {
    @State var isPickerShowing = false

    @EnvironmentObject private var eventVm: EventViewModel
    @State var event: Event
    var body: some View {   
        NavigationView{
            VStack{
                Form{
                
                    Section(header: Text("Event Details")) {
                        TextField("Name",text:$event.name)
                    
                        TextField("Address",text:$event.address)
                        
                       
                        
                    }
                    
                    
                    
                    
                    
                }
            }
            
        }
        
        
    }
}

struct AddStore_Previews: PreviewProvider {
    static var previews: some View {
        AddStore(event: Event())
        .environmentObject(EventViewModel())
        
    }
}
