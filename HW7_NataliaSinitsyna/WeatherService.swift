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
    
    func downloadWeather(city: City, completion: @escaping downloadWeatherCompletion) {
        Alamofire.request(Router.getWeather(q: city.id, appId: "d185d3526cd34f6cca61803414a1c14b")).responseJSON { [weak self] response in
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
        //let jsonArray = json["list"]
        //for (_, item) in jsonArray {
        var weatherArray = [Weather]()
        for (_, subJson):(String, JSON) in json["list"] {
        
            if  let addWeather = Weather(subJson) {
                weatherArray.append(addWeather)
            }
            
        }
        saveCityWeather(weatherArray: weatherArray)
   }
    
    private func saveCityWeather(weatherArray: [Weather]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(Weather.self))
                realm.add(weatherArray)
            }
        }  catch {
            print(error)
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




