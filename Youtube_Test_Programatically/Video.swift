//
//  Video.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumnailImageName: String?
    var title: String?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name:String?
    var profileImageName: String?
}