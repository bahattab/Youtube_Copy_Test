//
//  Video.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(value: AnyObject?, forKey key: String) {
        //Avoid that the app chrashes if a new key in the Json is added.
        let upperCaseFirstCharacter = String(key.characters.first!).uppercaseString
        let range = key.startIndex...key.startIndex.advancedBy(0)
        let selectorString = key.stringByReplacingCharactersInRange(range, withString: upperCaseFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.respondsToSelector(selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}


class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if key == "channel" {
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            channel?.setValuesForKeysWithDictionary(channelDictionary)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dictionary)
    }
    
}

class Channel: SafeJsonObject {
    var name:String?
    var profile_image_name: String?
}