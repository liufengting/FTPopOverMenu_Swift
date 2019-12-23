//
//  FTPopOverMenuCell.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 28/07/2017.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

class FTPopOverMenuCell: UITableViewCell {

    fileprivate lazy var iconImageView : UIImageView = {
        let imageView = UIImageView(frame: CGRect.zero)
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.contentView.addSubview(imageView)
        return imageView
    }()

    fileprivate lazy var nameLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.backgroundColor = UIColor.clear
        self.contentView.addSubview(label)
        return label
    }()

    func setupCellWith(menuName: FTMenuObject, menuImage: Imageable?, configuration: FTConfiguration) {
        self.backgroundColor = UIColor.clear
        
        // Configure cell text
        nameLabel.font = configuration.textFont
        nameLabel.textColor = configuration.textColor
        nameLabel.textAlignment = configuration.textAlignment
        nameLabel.frame = CGRect(x: FT.DefaultCellMargin, y: 0, width: configuration.menuWidth - FT.DefaultCellMargin*2, height: configuration.menuRowHeight)
        
        var iconImage : UIImage? = nil
        if menuName is String {
            nameLabel.text = menuName as? String
            iconImage = menuImage?.getImage()
        } else if menuName is FTPopOverMenuModel {
            nameLabel.text = (menuName as! FTPopOverMenuModel).title
            iconImage = (menuName as! FTPopOverMenuModel).image?.getImage()
            if ((menuName as! FTPopOverMenuModel).selected == true) {
                nameLabel.textColor = configuration.selectedTextColor
                self.backgroundColor = configuration.selectedCellBackgroundColor
            }
        }
        
        // Configure cell icon if available
        if iconImage != nil {
            if  configuration.ignoreImageOriginalColor {
                iconImage = iconImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            }
            iconImageView.tintColor = configuration.textColor
            iconImageView.frame =  CGRect(x: FT.DefaultCellMargin, y: (configuration.menuRowHeight - configuration.menuIconSize)/2, width: configuration.menuIconSize, height: configuration.menuIconSize)
            iconImageView.image = iconImage
            nameLabel.frame = CGRect(x: FT.DefaultCellMargin*2 + configuration.menuIconSize, y: (configuration.menuRowHeight - configuration.menuIconSize)/2, width: (configuration.menuWidth - configuration.menuIconSize - FT.DefaultCellMargin*3), height: configuration.menuIconSize)
        }
    }
}
