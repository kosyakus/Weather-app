//
//  WeatherService.swift
//  HW5_NataliaSinitsyna
//
//  Created by Admin on 29.06.17.
//  Copyright © 2017 GB. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class WeatherService {
    
    typealias downloadWeatherCompletion = () -> Void
    
    func downloadWeather(completion: @escaping downloadWeatherCompletion) {
        Alamofire.request(Router.getWeather(q: "Moscow,ru", appId: "d185d3526cd34f6cca61803414a1c14b")).responseJSON { [weak self] response in
            switch response.result {
            case .success(let rawJson):
                self?.parseWeatherFromJson(rawJson: rawJson)
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func parseWeatherFromJson(rawJson: Any) {
        let json = JSON(rawJson)
        //print(json)
        let jsonArray = json["list"]
        
        var cityArray = [City]()
        var weatherArray = [Weather]()
        
        for (_, item) in jsonArray {
            
            let addCity = City(json: item)
            
            if  let addCity = addCity {
                cityArray.append(addCity)
            }
            if let addWeather = Weather(json: item, city: addCity) {
                weatherArray.append(addWeather)
            }
            
        }
        saveCityWeather(cityArray: cityArray, weatherArray: weatherArray)
   }
    
    private func saveCityWeather(cityArray: [City], weatherArray: [Weather]) {
        do {
            let realm = try Realm()
            
            try realm.write {
            realm.add(cityArray)
            realm.add(weatherArray)
            }
        }  catch {
            print(error)
        }
    }
    
    func showCity() -> [City] {
        do {
            let realm = try Realm()
            let someCity = realm.objects(City.self)
            return Array(someCity)
        }  catch {
            print(error)
            return []
        }
    }
    
    func showWeather() -> [Weather] {
        do {
            let realm = try Realm()
            let someWeather = realm.objects(Weather.self)
            return Array(someWeather)
            
        }  catch {
            print(error)
            return []
        }
    }
}






