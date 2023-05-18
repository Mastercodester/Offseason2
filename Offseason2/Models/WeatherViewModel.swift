//
//  WeatherViewModel.swift
//  Offseason2
//
//  Created by Sean Carter on 5/17/23.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published private(set) var currentTemperature = String()
    @Published private(set) var currentCondition = String()
    @Published private(set) var dailyHighLow = "H:0 L:0"
    @Published private(set) var hourlyForecast = [HourWeather]()
    @Published private(set) var tenDayForecast = [DayWeather]()
    
    private let weatherService = WeatherService()
    private let currentLocation = CLLocation(latitude: 42.331429, longitude: -83.045753)
    
   
    
    init() {
        fetchCurrentWeather()
    }
    func fetchCurrentWeather(){
        Task{
            do {
                let weather = try await weatherService.weather(for:currentLocation)
                DispatchQueue.main.async {
                    self.currentTemperature = weather.currentWeather.temperature.formatted()
                    self.currentCondition = weather.currentWeather.condition.description
                    self.dailyHighLow = "H:\(weather.dailyForecast.forecast[0].highTemperature.formatted().dropLast()) L:\(weather.dailyForecast.forecast[0].lowTemperature.formatted().dropLast())"
                    
                    
                    
                    //hourly forecast
                    weather.hourlyForecast.forecast.forEach {
                        if self.isSameHourOrLater(date1: $0.date, date2: Date()) {
                            self.hourlyForecast.append(HourWeather(time: self.hourFormatter(date: $0.date), symbolName: $0.symbolName, temperature: "\($0.temperature.formatted().dropLast())"))
                        }
                    }
                    
                    //10 day forecast
                    
                    weather.dailyForecast.forecast.forEach {
                        self.tenDayForecast.append(DayWeather(day: self.dayFormatter(date: $0.date), symbolName: $0.symbolName, lowTemperature: "\($0.lowTemperature.formatted().dropLast())", highTemperature: "\($0.highTemperature.formatted().dropLast())"))
                        
                    }
                }
                
                
                
            } catch {
                print("Error fecthing weather data:", error)
            }
        }
    }
    
    
    func hourFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        
        let calendar = Calendar.current
        let inputDateComponents = calendar.dateComponents([.day, .hour], from: date)
        let currentDateComponents = calendar.dateComponents([.day, .hour], from: Date())
        
        if inputDateComponents == currentDateComponents {
            return "Now"
        }else{
            return dateFormatter.string(from: date)
        }
    }
    
    func isSameHourOrLater(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        let comparisonResult = calendar.compare(date1, to: date2, toGranularity: .hour)
        
        return comparisonResult == .orderedSame || comparisonResult == .orderedDescending
    }
    
    func dayFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let calendar = Calendar.current
        let inputDateComponents = calendar.dateComponents([.day], from: date)
        let currentDateComponents = calendar.dateComponents([.day], from: Date())
        
        if inputDateComponents == currentDateComponents{
            return "Today"
        }else{
            return dateFormatter.string(from: date)
        }
        
    }
}
    
struct HourWeather{
        let time: String
        let symbolName: String
        let temperature: String
    }
    
    struct DayWeather: Hashable{
        let day: String
        let symbolName: String
        let lowTemperature: String
        let highTemperature: String
    }
