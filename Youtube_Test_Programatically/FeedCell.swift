//
//  FeedCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 19/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(collectionView)
        addConstrainstWithFormat("H:|[v0]|", views: collectionView)
        addConstrainstWithFormat("V:|[v0]|", views: collectionView)
    }
}
