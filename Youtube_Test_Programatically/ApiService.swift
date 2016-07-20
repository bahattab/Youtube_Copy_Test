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
                
                if let unwrappedData = data, jsonDictionaries = try NSJSONSerialization.JSONObjectWithData(unwrappedData, options: .MutableContainers) as? [[String: AnyObject]]{
                    
                    
                    //Simplified version
                    let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(videos)
                    })
                    
                    //Not simplified version
                    /*var videos = [Video]()
                    
                    for dictionary in jsonDictionaries {
                        
                            //print(dictionary["title"])
                            //let video = Video()
                            //video.title = dictionary["title"] as? String
                            //video.thumnailImageName = dictionary["thumbnail_image_name"] as? String
                            
                            //video.setValuesForKeysWithDictionary(dictionary)
                            
                            //It is simplified in Video Class
                            /*let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                             let channel = Channel()
                             channel.setValuesForKeysWithDictionary(channelDictionary)
                             video.channel = channel
                             */
                            
                            let video = Video(dictionary: dictionary)
                            videos.append(video)
                            
                        
                        
                        dispatch_async(dispatch_get_main_queue(), {
                        completion(videos)
                        })
                    }
                    */
                    
                }
                
                
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            
            }.resume()
    }

    
}
