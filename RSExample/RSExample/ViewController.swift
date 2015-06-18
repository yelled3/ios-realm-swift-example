//
//  ViewController.swift
//  RSExample
//
//  Created by Adam Farhi on 6/18/15.
//  Copyright (c) 2015 Smore. All rights reserved.
//

import UIKit

import RealmSwift
import SwiftyJSON


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        createMockData()
        
        runQuery()
    }

    
    func runQuery() -> Void {
        
    }
    
    
    func createMockData() -> Void {
        
        var users: [Person] = []

        for (key: String, json: JSON) in staticMockDataJSON {
            
            var id: String = json["id"].string!
            var firstName: String = json["first_name"].string!
            var lastName: String = json["last_name"].string!
            var email: String = json["email"].string!
            var country: String = json["country"].string!
            var married: Bool = json["married"].bool!
            
            var currentUser: Person = Person()
            
            currentUser.id = id
            currentUser.firstName = firstName
            currentUser.lastName = lastName
            currentUser.email = email
            currentUser.country = country
            currentUser.married = married
            
            var currentDogs: [Dog] = []
            
            for (key: String, dogJson: JSON) in json["dogs"] {

                var dogId: String = dogJson["id"].string!
                var dogName: String = dogJson["name"].string!
                
                var currentDog: Dog = Dog()
                
                currentDog.id = dogId
                currentDog.name = dogName
                currentDog.owner = currentUser
                
                currentDogs.append(currentDog)
                
            }
            
            users.append(currentUser)
            
        }
        
        NSLog("Parsed mock data")
        
        
        // Get the default Realm
        let realm = Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        realm.write {
            realm.add(users)
        }
        
        NSLog("Done")
        
    }


}

