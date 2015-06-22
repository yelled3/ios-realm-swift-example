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
        
        
        NSLog(Realm.defaultPath)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        bindNotifications()
        
//        createMockData()
        
        runQuery()
        
//        runUpdate()
        
    }
    
    func bindNotifications() -> Void {
        
        let realm = Realm()
        
        // Observe Realm Notifications
        let token: NotificationToken = realm.addNotificationBlock { notification, realm in
            NSLog("notification - \(notification.rawValue)")
        }
        
        NSLog("bindNotifications Done")
        
    }

    
    func runUpdate() -> Void {
        
        let realm = Realm()
        
        
        let users: Results<Person> = realm.objects(Person)
        
        
        realm.write {
            var name = users.first!.firstName
            users.first!.firstName = "\(name) [updated]"
        }
        
        NSLog("run update done")
    }
    
    
    
    func runQuery() -> Void {
        
        let realm = Realm()
        
        
        let users: Results<Person> = realm.objects(Person)
        
        NSLog("users: \(users.count)")
        
        let usersFiltered: Results<Person> = users.filter("married = YES AND firstName BEGINSWITH 'A'")
        
        NSLog("usersFiltered 1: \(usersFiltered.count)")
        
 
        for user in usersFiltered {
            
            for dog: Dog in user.dogs {
                
                if let ownerId = dog.owner?.id {
                    if ownerId == user.id {
                        NSLog("same id - \(ownerId)")
                    } else {
                        NSLog("not same id - \(ownerId) \(user.id)")
                    }
                    
                } else {
                    NSLog("no owner id")
                }
            }
        }
        
        NSLog("usersFiltered 2: \(usersFiltered.count)")
        
        var someUser: Person = users.first!
        var userId = someUser.id
        
        var loadedUser: Person = realm.objectForPrimaryKey(Person.self, key: userId)!
        
        
        NSLog("old id - \(userId)")
        NSLog("new id - \(loadedUser.id)")
        

        
        var allDogs: Results<Dog> = realm.objects(Dog)
        
        var ownerWithA: Results<Dog> = allDogs.filter("owner.firstName BEGINSWITH 'A'")
        
        var dogsQuery: Results<Dog> = ownerWithA.filter("name BEGINSWITH 'A'")
        
        NSLog("<<< userWithDogs")
        
        NSLog("userWithDogs count: \(dogsQuery.count)")
        
        for dog in dogsQuery {
            if let owner = dog.owner {
                NSLog("owner: \(owner.firstName) -> \(dog.name)")
            } else {
                NSLog("no owner for dog \(dog.name)")
            }
            
        }
        
        NSLog("userWithDogs >>>>")
        

        
        
//        var userQuery = realm.objects(Person).filter("ANY dogs.name == 2")
//        
//        for user in userQuery {
//            
//            
//            NSLog("user.dogs.count - \(user.dogs.count)")
//            
//        }
        
        
        NSLog("Done query")
        
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
            
            var currentDogs: List<Dog> = List<Dog>()
            
            for (key: String, dogJson: JSON) in json["dogs"] {

                var dogId: String = dogJson["id"].string!
                var dogName: String = dogJson["name"].string!
                
                var currentDog: Dog = Dog()
                
                currentDog.id = dogId
                currentDog.name = dogName
                currentDog.owner = currentUser
                
                currentDogs.append(currentDog)
            }
            
            currentUser.dogs.extend(currentDogs)
            
            users.append(currentUser)
            
        }
        
        NSLog("Parsed mock data")
        
        
        // Get the default Realm
        let realm = Realm()
        // You only need to do this once (per thread)
        
        // Add to the Realm inside a transaction
        realm.write {
            realm.add(users, update: true)
        }
        
        NSLog("Done")
        
    }


}

