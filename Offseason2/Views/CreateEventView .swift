//
//  CreateEventView .swift
//  TheMove
//
//  Created by Jacquese Whitson  on 5/17/23.
//

import SwiftUI

struct CreateEventView: View {
    var body: some View {

        NavigationStack {
            VStack{
                ZStack{
                    Image ("wtm")
                        .resizable()
                        .scaledToFill()
                        .frame(width:350,height: 240)
                        .cornerRadius(10)
                        .clipped()
                    HStack{
                        Button{}
                    label:{
                            Image(systemName: "photo")
                            Text("Cover Photos")
                    }
                    }
                    .foregroundColor(.black)
                    .padding()
                    .background(Color("slime"))
                    .cornerRadius(20)

                    
                }
                Spacer()
                
//                
//                TextField("", text: <#T##Binding<String>#>)
                
                
                
                
                
                
                
                
                
            }
            .toolbar{
                ToolbarItemGroup(placement: .cancellationAction) {
                    cancelButton
                    
                }
                
                ToolbarItemGroup(placement: .confirmationAction) {
                    doneButton
                    
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Creat an event")
        }
        
    
    }
    
    
    // private var
    // new code ⚡️
    var doneButton : some View {
        Button("Done"){}
            .foregroundColor(Color("slime"))
    }
    
    // new code ⚡️

    var cancelButton : some View {
        Button{
            
        }label: {
        Image(systemName: "x.circle")
        }
    }
    
    
}// end of struct

struct CreateEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
        
    }
    
}



    
