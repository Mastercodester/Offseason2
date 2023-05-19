//
//  LocationMapPin.swift
//  Offseason2
//
//  Created by Jacquese Whitson  on 5/19/23.
//

import SwiftUI

struct LocationMapPin: View {
    var body: some View {
        VStack(spacing: 0){
            Image(systemName: "football")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(.red)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.red)
                .frame(width: 10,height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y:-3)
                .padding(.bottom,40)

            // to change how far up or how far dpown the pin is
//                .padding(45)

        }
    }
}


struct LocationMapPin_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapPin()
    }
}
