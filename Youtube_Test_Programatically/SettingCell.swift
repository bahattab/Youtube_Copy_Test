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
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func setUpViews() {
        super.setUpViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        addConstrainstWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImageView,nameLabel)
        addConstrainstWithFormat("V:|[v0]|", views: nameLabel)
        addConstrainstWithFormat("V:[v0(30)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

    }
}
