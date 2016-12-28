//
//  FeedCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 19/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class FeedCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var videos: [Video]?
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchVideosHome { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
        fetchVideos()
        

        addSubview(collectionView)
        addConstrainstWithFormat("H:|[v0]|", views: collectionView)
        addConstrainstWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return videos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //To display videos, they should have a ratio of 16/9
        //We substract the padding and apply the ratio.
        let height = (frame.width - 16 - 16) * 9/16
        //For the final height we have to add the contribution of the other elements
        //88 = 8  + 36 + 44
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}
