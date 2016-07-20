//
//  SubscriptionCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 20/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
