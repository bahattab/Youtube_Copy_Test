//
//  SettingCell.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 18/07/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .ScaleAspectFill
        return imageView
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstrainstWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstrainstWithFormat("V:|[v0]|", views: nameLabel)
        addConstrainstWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))

    }
}
