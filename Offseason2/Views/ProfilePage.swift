//
//  ContentView.swift
//  ybi
//
//  Created by Ravyn Dobine on 5/17/23.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    Image(systemName:"person.circle.fill")
                        .resizable()
                        .frame(width:100, height:100)
                        .offset(x:40, y:-10)
                    
                        .padding(.top, -0)
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size:35))
                        .foregroundColor(.orange)
                        .offset(x:40, y:-20)
                    Button("sign out", action: {
                    print ("Hello World")
                        })
                        .font(.system(size:20))
                        .foregroundColor(.red)
                        .offset(x:125, y:-35)
                        .fontWeight(.bold)
            

                }
                .frame(maxWidth:.infinity, maxHeight:.infinity,
                       alignment:.leading)
                
                VStack{
                    Text("Blade Icewood")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.monospaced)
                        .offset(x:145, y:-50)
                    Button("edit", action: {
                    print ("Hello World" )
                        })
                        .font(.subheadline)
                        .foregroundColor(.indigo)
                        .fontWeight(.thin)
                        .fontDesign(.monospaced)
                        .padding(-40)
                        .offset(x:75, y:-25)
                  
                    Text("bladeicewood@gmail.com")
                        .font(.body)
                        .fontDesign(.monospaced)
                        .fontWeight(.semibold)
                        .offset(x:70,y:2)
                    Button("edit", action: {
                    print ("Hello World")
                        })
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .offset(x:70,y:4)
                    Text("********")
                        .font(.body)
                        .fontDesign(.monospaced)
                        .fontWeight(.semibold)
                        .offset(x:70,y:20)
                    Button("edit", action: {
                    print ("Hello World")
                        })
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .offset(x:70,y:20)
                    Text("(313) 333 3133")
                        .font(.body)
                        .fontDesign(.monospaced)
                        .fontWeight(.semibold)
                        .offset(x:70,y:40)
                    Button("edit", action: {
                    print ("Hello World")
                        })
                        .font(.subheadline)
                        .fontWeight(.thin)
                        .offset(x:70,y:40)
                   
                 
                
                }
            
                .frame(maxWidth:.infinity, maxHeight:.infinity,
                       alignment:.leading)

            }
            
        
    }
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
