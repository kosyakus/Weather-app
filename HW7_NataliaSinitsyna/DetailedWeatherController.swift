//
//  DetailedWeatherController.swift
//  HW7_NataliaSinitsyna
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 GB. All rights reserved.
//

import UIKit
import RealmSwift

class DetailedWeatherController: UITableViewController {
    
    let weatherService = WeatherService()
    var city: City?
    var weatherDate = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let city = self.city else { return }
        
        weatherDate = weatherService.showWeather()
        tableView.reloadData()
        
        weatherService.downloadWeather(city: city) { [weak self] in
            self?.weatherDate = self?.weatherService.showWeather() ?? []
            self?.tableView.reloadData()
        }
               // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDate.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! DetailedCell
        
        let weather = weatherDate[indexPath.row]
       
        cell.labelDate.text = weather.date
        cell.labelTemp.text = String(format: "%.1f C", (weather.temperature-273.15))
        
        let imgURL:URL = URL(string: weather.icon)!
        let imgData = try! Data(contentsOf: imgURL)
        cell.imagePng.image = UIImage(data: imgData)
        cell.labelDescr.text = weather.descr
       
        return cell
    }

}
