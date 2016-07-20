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
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideosHome(completion: ([Video]) ->()) {
        let url = "\(baseUrl)/home.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchTrendingFeed(completion: ([Video]) ->()) {
        let url = "\(baseUrl)/trending.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionFeed(completion: ([Video]) ->()) {
        let url = "\(baseUrl)/subscriptions.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchFeedForUrlString(urlString: String, completion: ([Video]) ->()) {
        let url = NSURL(string: urlString)
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
