//
//  ApiService.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 19/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: ([Video]) ->()) {
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
        
        if error != nil {
        print(error)
        return
        }
        
        do {
        
        var videos = [Video]()
        
        let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
        
        
        for dictionary in json as! [[String: AnyObject]] {
        //print(dictionary["title"])
        let video = Video()
        video.title = dictionary["title"] as? String
        video.thumnailImageName = dictionary["thumbnail_image_name"] as? String
        
        let channelDictionary = dictionary["channel"] as! [String: AnyObject]
        
        let channel = Channel()
        channel.name = channelDictionary["name"] as? String
        channel.profileImageName = channelDictionary["profile_image_name"] as? String
        
        video.channel = channel
        
        videos.append(video)
        
        }
        
        dispatch_async(dispatch_get_main_queue(), {
            completion(videos)
        })
        
        
        } catch let jsonError {
        print(jsonError)
        }
        
        
        
        }.resume()
    }
    
}
