//
//  TrendingCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 20/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
