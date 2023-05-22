//
//  ProductCard.swift
//  SweaterShopDemo
//
//  Created by Jacquese Whitson  on 2/24/23.
//

import SwiftUI
 
    // this page is setting up the ui for each of our  cards 
// we are making it accept data from our "Product" struct we built on the other page


//struct ExploreCard: View {
//
////    let product access all the values fromt the prodict struct
////    @EnvironmentObject var cartManager : CartManagement
//
//    var product : Product
//    var body: some View {
//        ZStack(alignment: .topTrailing){
//
//            ZStack(alignment:.bottom){
//                Image(product.image)
//                    .resizable()
//                    .cornerRadius(20)
//                    .frame(width: 180)
//                    .scaledToFit()
//
//                VStack(alignment: .leading){
//                    Text(product.name)
//                        .bold()
//                Text("\(product.price)$")
//                        .font(.caption)
//                }
//                .padding()
//                .frame(width: 180, alignment: .leading)
//                .background(.ultraThinMaterial)
//                .cornerRadius(20)
//
//
//
//
//            }
//            .frame(width: 180,height: 250)
//        .shadow(radius: 3)
//
//
//            // created the lil plus button in top of corner
//            Button(){
//                // accesing data from inside our cartManger class
//        // this time we want to call a functon thats stored in there
//                // so we run that code when the button is pressed
////                cartManager.addToCart(product: product)
//            } label: {
//                Image(systemName: "plus")
//                    .padding(10)
//                    .foregroundColor(.white)
//                    .background(.black)
//                    .cornerRadius(50)
//                    .padding()
//            }
//        }
//
//
//    }
//}


// when passing through data we gota have soemthing to showw
//struct ProductCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductCard(product: productList[0])
//            .environmentObject(CartManagement())
//    }
//}
