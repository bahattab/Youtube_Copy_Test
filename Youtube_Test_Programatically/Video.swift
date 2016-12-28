//
//  Video.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        //Avoid that the app chrashes if a new key in the Json is added.
        let upperCaseFirstCharacter = String(key.characters.first!).uppercased()
//       let range = key.startIndex...key.characters.index(key.startIndex, offsetBy: 0)
//         let selectorString = key.replacingCharacters(in: range, with: upperCaseFirstCharacter)
        
        let range = NSMakeRange(0,1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: upperCaseFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
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
    var uploadDate: Date?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            channel?.setValuesForKeys(channelDictionary)
        }
        else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}

class Channel: SafeJsonObject {
    var name:String?
    var profile_image_name: String?
}
