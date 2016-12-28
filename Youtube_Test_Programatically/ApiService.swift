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
    
    func fetchVideosHome(_ completion: @escaping ([Video]) ->()) {
        let url = "\(baseUrl)/home.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) ->()) {
        let url = "\(baseUrl)/trending.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchSubscriptionFeed(_ completion: @escaping ([Video]) ->()) {
        let url = "\(baseUrl)/subscriptions.json"
        
        fetchFeedForUrlString(url) { (videos) in
            completion(videos)
        }
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) ->()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            do {
                
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]]{
                    
                    
                    //Simplified version
                    let videos = jsonDictionaries.map({return Video(dictionary: $0)})
                    DispatchQueue.main.async(execute: {
                        completion(videos)
                    })
                    
                    //Examples of map
                    /*
                    let numbersArray = [1, 2 , 3]
                    let doubleNumbersArray = numbersArray.map({return $0 * 2})
                    let stringArray = numbersArray.map({return "\($0 * 2)"})
                    */
                    
                    
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
            
            
            
            }) .resume()
    }

    
}
