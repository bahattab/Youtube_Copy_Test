//
//  ViewController.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellId", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }


}

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        imageView.image = UIImage(named: "taylor-swift")
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purpleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.redColor()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let sepatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        return view
    }()
    
    func setUpViews() {
        addSubview(thumbnailImageView)
        addSubview(userProfileImageView)
        addSubview(sepatorView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        //Cleaner way to do it
        
        addConstrainstWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstrainstWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        addConstrainstWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView,userProfileImageView, sepatorView)
        addConstrainstWithFormat("H:|[v0]|", views: sepatorView)
        
        //Constraints for Title Label
        //Top
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        
        //Left
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        
        //Right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        
        //Height
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20))
        
        //Constraints for SubTitle Text View
        //Top
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 8))
        
        //Left
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        
        //Right
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        
        //Height
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20))
        
        
        /*One way to do it
        //Add Padding to Thumbnail Image
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
        
        //Add Constraints to Seperator Line
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : sepatorView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : sepatorView]))
        */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addConstrainstWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for(index, view) in views.enumerate(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

