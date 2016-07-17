//
//  VideoCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 17/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            if let thumbnailImage = video?.thumnailImageName {
                thumbnailImageView.image = UIImage(named: thumbnailImage)
            }
            
            if let profileImage = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImage)
                subtitleTextView.text = video?.channel?.name
            }
            
        }
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "swift-youtube")
        
        //When no image assigned we could use the following to test the layout
        //imageView.backgroundColor = UIColor.blueColor()
        
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_profile")
        
        //The image is displayed in a circle form
        //Half of the width and height, Width and height equal to 44.
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Black Space"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO - 1,604,586,092 views - 2 years ago"
        textView.textColor = UIColor.grayColor()
        //Text Views have some pixels that we need to remake
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        
        return textView
    }()
    
    let sepatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    override func setUpViews() {
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
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        
        //Left
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Left, relatedBy: .Equal, toItem: userProfileImageView, attribute: .Right, multiplier: 1, constant: 8))
        
        //Right
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnailImageView, attribute: .Right, multiplier: 1, constant: 0))
        
        //Height
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
        
        /*One way to do it
         //Add Padding to Thumbnail Image
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : thumbnailImageView]))
         
         //Add Constraints to Seperator Line
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : sepatorView]))
         addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : sepatorView]))
         */
    }
}
