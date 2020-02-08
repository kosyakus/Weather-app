//
//  AddCityController.swift
//  HW7_NataliaSinitsyna
//
//  Created by Admin on 05.07.17.
//  Copyright © 2017 GB. All rights reserved.
//

import UIKit
import RealmSwift

class AddCityController: UIViewController {

    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var cityId: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard !cityName.text!.isEmpty, !cityId.text!.isEmpty else { return }
        
        let newCity = City()
        newCity.title = cityName.text!
        newCity.id = cityId.text!
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(newCity)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
}
