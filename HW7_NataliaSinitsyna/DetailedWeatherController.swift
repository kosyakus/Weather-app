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
    //let imageArray = ["sun.jpg", "snow.png", "clouds.jpg", "cloudsWsun.jpg", "cloudsWthunder.jpg"]
    

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
       // cell.imageView?.image = weatherService.getImage[indexPath.row]
        
        let imgURL:URL = URL(string: weather.icon)!
        let imgData = try! Data(contentsOf: imgURL)
        cell.imagePng.image = UIImage(data: imgData)
        cell.labelDescr.text = weather.descr
       // cell.imageView?.image = UIImage(data: weather.icon)
        
        
       // cell.detailTextLabel?.text = String(format: "%.1f C", (weather.temperature-273.15))
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
