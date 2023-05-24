//
//  ContentView.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI

struct ContentView: View {
    init () {
        UITabBar.appearance().backgroundColor = UIColor( Color(.black))
        
    }
    
 
 
    var body: some View {
        NavigationView{
             TabView{
                 Group{
                     Home_Page(event: Event(), player: Player())
                         .tabItem{
                             Label("Home",systemImage: "house.circle")
                            
                         }
                   ExplorePage()
                         .tabItem{
                             Label("Explore",systemImage: "magnifyingglass.circle")
                             Image(systemName: "")
                         }
                     Mygames()
                         .tabItem{
                             Label("My Games",systemImage: "flag.2.crossed.circle.fill")
                            }
                     
              ProfilePage()
                     
                     .tabItem{
                             Label("Profile",systemImage: "person.crop.circle")
                             
                               
                         }
                     
                 }
                 .toolbar(.visible, for: .tabBar)
                     .toolbarBackground(Color(.black), for: .tabBar)
             }.toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color(.black), for: .tabBar).accentColor(Color(.white))
             
            

        }
 //            .onAppear {
 //            let appearance = UINavigationBarAppearance()
 //            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
 //            appearance.backgroundColor = UIColor(Color("secondary"))
 //            UINavigationBar.appearance().scrollEdgeAppearance = appearance
 //        }
         
     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
