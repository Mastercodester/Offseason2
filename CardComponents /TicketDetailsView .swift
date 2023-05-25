//
//  TicketDetailsView .swift
//  TheMove
//
//  Created by Jacquese Whitson  on 4/30/23.
//

import CoreLocation
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import MapKit
import SwiftUI
import FirebaseStorage
struct TicketDetailsView: View {
    var fans = [ "j"]
    @EnvironmentObject private var vm : EventViewModel
    var body: some View {
        
    //TODO: we need to put this into a private func when we run it fr
        VStack(alignment: .leading){
            HStack{
                Text("+5.91 fee")
                Spacer()
                Text("sales end on June 1,2023")
                
            }
            
            HStack{
                Text("Tickets Include:")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
                Text("40 Remaining")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .bold()
            }
                Text("- 2 Free Drinks ")
                Text("- xxx")
                Text("- xxxxxxx")
            Spacer()
        }
        .padding()
    }
    
    private func TicketDetailView(_ event: Event) -> some View {
        VStack(alignment: .leading){
            HStack{
                Text("+5.91 fee")
                Spacer()
                Text("sales end on June 1,2023")
                
            }
            
            HStack{
                Text("Tickets Include:")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .bold()
                Spacer()
                Text("40 Remaining")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .bold()

                
            }
                Text("- 2 Free Drinks ")
                Text("- xxx")
                Text("- xxxxxxx")
                
            
        
            Spacer()
        }
        
        
        
    }

}

struct TicketDetailsView__Previews: PreviewProvider {
    static var previews: some View {
        TicketDetailsView()
            .environmentObject(EventViewModel())
    }
}
