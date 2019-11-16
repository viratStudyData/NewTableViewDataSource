//
//  Event.swift
//  Phunware
//
//  Created by Gurleen on 20/08/19.
//  Copyright © 2019 Code Brew Labs. All rights reserved.
//

import UIKit
import Foundation

class Event: Codable {
    var meta: Meta?
    var data: Event?
}

class Meta: Codable {
    var type: String?
    var statusCode: Int?
    var message: String?
    
}

class EventData: Codable {
    
    var date : String?
    var description : String?
    var id : Int?
    var image : String?
    var locationline1 : String?
    var locationline2 : String?
    var phone : String?
    var timestamp : String?
    var title : String?
    
}

//class Event : NSObject, NSCoding{
//
//    var date : String?
//    var descriptionField : String?
//    var id : Int?
//    var image : String?
//    var locationline1 : String?
//    var locationline2 : String?
//    var phone : String?
//    var timestamp : String?
//    var title : String?
//
//
//    /**
//     * Instantiate the instance using the passed dictionary values to set the properties values
//     */
//    init(fromDictionary dictionary: [String:Any]){
//        date = dictionary["date"] as? String
//        descriptionField = dictionary["description"] as? String
//        id = dictionary["id"] as? Int
//        image = dictionary["image"] as? String
//        locationline1 = dictionary["locationline1"] as? String
//        locationline2 = dictionary["locationline2"] as? String
//        phone = dictionary["phone"] as? String
//        timestamp = dictionary["timestamp"] as? String
//        title = dictionary["title"] as? String
//    }
//
//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if date != nil{
//            dictionary["date"] = date
//        }
//        if descriptionField != nil{
//            dictionary["description"] = descriptionField
//        }
//        if id != nil{
//            dictionary["id"] = id
//        }
//        if image != nil{
//            dictionary["image"] = image
//        }
//        if locationline1 != nil{
//            dictionary["locationline1"] = locationline1
//        }
//        if locationline2 != nil{
//            dictionary["locationline2"] = locationline2
//        }
//        if phone != nil{
//            dictionary["phone"] = phone
//        }
//        if timestamp != nil{
//            dictionary["timestamp"] = timestamp
//        }
//        if title != nil{
//            dictionary["title"] = title
//        }
//        return dictionary
//    }
//
//    /**
//     * NSCoding required initializer.
//     * Fills the data from the passed decoder
//     */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//        date = aDecoder.decodeObject(forKey: "date") as? String
//        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//        id = aDecoder.decodeObject(forKey: "id") as? Int
//        image = aDecoder.decodeObject(forKey: "image") as? String
//        locationline1 = aDecoder.decodeObject(forKey: "locationline1") as? String
//        locationline2 = aDecoder.decodeObject(forKey: "locationline2") as? String
//        phone = aDecoder.decodeObject(forKey: "phone") as? String
//        timestamp = aDecoder.decodeObject(forKey: "timestamp") as? String
//        title = aDecoder.decodeObject(forKey: "title") as? String
//
//    }
//
//    /**
//     * NSCoding required method.
//     * Encodes mode properties into the decoder
//     */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if date != nil{
//            aCoder.encode(date, forKey: "date")
//        }
//        if descriptionField != nil{
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if id != nil{
//            aCoder.encode(id, forKey: "id")
//        }
//        if image != nil{
//            aCoder.encode(image, forKey: "image")
//        }
//        if locationline1 != nil{
//            aCoder.encode(locationline1, forKey: "locationline1")
//        }
//        if locationline2 != nil{
//            aCoder.encode(locationline2, forKey: "locationline2")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if timestamp != nil{
//            aCoder.encode(timestamp, forKey: "timestamp")
//        }
//        if title != nil{
//            aCoder.encode(title, forKey: "title")
//        }
//
//    }
//
//}
