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
        cv.backgroundColor = UIColor.whiteColor()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(collectionView)
        addConstrainstWithFormat("H:|[v0]|", views: collectionView)
        addConstrainstWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.registerClass(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath)
        
        return cell
    }
}
