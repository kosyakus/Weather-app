//
//  CitiesTableViewController.swift
//  HW7_NataliaSinitsyna
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 GB. All rights reserved.
//

import UIKit
import  RealmSwift

class CitiesTableViewController: UITableViewController {
    
    var cities: Results<City>?

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        let realm = try! Realm()
        cities =  realm.objects(City.self).sorted(byKeyPath: "title")
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)

        guard let city = cities?[indexPath.row] else { return cell }
        
        cell.textLabel?.text = city.title
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            do {
            let realm = try Realm()
            try realm.write {
                realm.delete((self.cities?[indexPath.row])!)
                //realm.delete(realm.objects(City.self)[indexPath.row]) //.sorted(byKeyPath: "title"))
                }
            }  catch {
            print(error)
        }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "f_city_t_weather" {
            let someVar = segue.destination as! DetailedWeatherController
            let cell = sender as! UITableViewCell
            let indexPathNew = tableView.indexPath(for: cell)
            
            someVar.city = cities![indexPathNew!.row]
        }
    }
    

}
