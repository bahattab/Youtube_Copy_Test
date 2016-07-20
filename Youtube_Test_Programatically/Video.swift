//
//  Video.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class Video: NSObject {
    
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
    
}

class Channel: NSObject {
    var name:String?
    var profile_image_name: String?
}