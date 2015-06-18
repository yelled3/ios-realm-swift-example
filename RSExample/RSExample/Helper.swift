//
//  Helper.swift
//  RSExample
//
//  Created by Adam Farhi on 6/18/15.
//  Copyright (c) 2015 Smore. All rights reserved.
//

import SwiftyJSON

class StaticHelper {
    class func loadFixtureJSON(#fileName: String) -> JSON {
        var filePath: NSString = NSBundle(forClass: self).pathForResource(fileName, ofType: "json")!
        var data = NSData(contentsOfFile: filePath as String)!
        return JSON(data: data, options: .AllowFragments, error: nil)
    }
}

var staticMockDataJSON: JSON = StaticHelper.loadFixtureJSON(fileName: "MOCK_DATA")
