//
//  Models.swift
//  RSExample
//
//  Created by Adam Farhi on 6/18/15.
//  Copyright (c) 2015 Smore. All rights reserved.
//

import RealmSwift


// Dog model
class Dog: Object {
    dynamic var id: String = ""
    dynamic var name = ""
    dynamic var owner: Person? // Can be optional
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

// Person model
class Person: Object {
    
    dynamic var id: String = ""
    
    var fullName: String { // computed properties are automatically ignored
    return "\(firstName) \(lastName)"
    }
    
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    
    dynamic var email: String = ""
    
    dynamic var country: String = ""
    
    dynamic var married: Bool = false
    
    dynamic var birthdate = NSDate(timeIntervalSince1970: 1)
    
    let dogs = List<Dog>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
}

