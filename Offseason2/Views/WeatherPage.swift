//
//  WeatherPage.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherPage: View {
    @StateObject private var weatherViewModel = WeatherViewModel()
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .blue, .orange]),
                           startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.vertical)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    Text("Current Location")
                        .font(.title)
                    
                    Text(weatherViewModel.currentTemperature.dropLast())
                        .font(.system(size:72))
                        .fontWeight(.light)
                    
                    Text(weatherViewModel.currentCondition)
                    
                    Text(weatherViewModel.dailyHighLow)
                    
                    
                    
                }.foregroundColor(.white)
                    .padding()
                
                
                VStack(alignment:.leading) {
                    Label("hourly forecast" .uppercased(), systemImage: "clock")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(weatherViewModel.hourlyForecast, id: \.time) {
                                weather in
                                VStack(spacing: 12) {
                                    Text(weather.time)
                                        .font(.caption)
                                    
                                    Image(systemName: "\(weather.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    
                                    Text(weather.temperature)
                                        .fontWeight(.semibold)
                                    
                                }
                                .padding()
                            }
                            
                        }
                    }
                }
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
                
                VStack(alignment:.leading){
                    Label("10-day forecast" .uppercased(), systemImage:"calendar")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding([.top, .leading])
                    
                    VStack {
                        ForEach(weatherViewModel.tenDayForecast, id: \.self) {
                            weather in
                            HStack {
                                Text(weather.day)
                                    .frame(width: 48, alignment: .leading)
                                
                                Image(systemName: "\(weather.symbolName).fill")
                                    .font(.title2)
                                    .padding(.horizontal)
                                    .symbolRenderingMode(.multicolor)
                                
                                Text(weather.lowTemperature)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                
                                ZStack(alignment: .trailing) {
                                    Capsule()
                                    
                                    LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .leading, endPoint: .trailing)
                                        .clipShape(Capsule())
                                        .frame(width: 72)
                                }
                                .frame(height: 6)
                                
                                Text(weather.highTemperature)
                                    .fontWeight(.semibold)
                                
                            }
                            .padding()
                        }
                    }
                }
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 8))
                .padding()
            }
        }
    }
}
struct Weather_Page_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPage().environmentObject(WeatherViewModel())
    }
}

