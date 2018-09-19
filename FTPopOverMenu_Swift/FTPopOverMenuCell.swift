//
//  FTPopOverMenuCell.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 28/07/2017.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

class FTPopOverMenuCell: UITableViewCell {

    fileprivate lazy var configuration : FTConfiguration = {
        return FTConfiguration.shared
    }()

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

    func setupCellWith(menuName: String, menuImage: Imageable?, cellConfiguration: FTCellConfiguration) {
        self.backgroundColor = UIColor.clear
        
        // Configure cell text
        nameLabel.font = cellConfiguration.textFont
        nameLabel.textColor = cellConfiguration.textColor
        nameLabel.textAlignment = cellConfiguration.textAlignment
        nameLabel.text = menuName
        nameLabel.frame = CGRect(x: FT.DefaultCellMargin, y: 0, width: configuration.menuWidth - FT.DefaultCellMargin*2, height: configuration.menuRowHeight)
        
        // Configure cell icon if available
        if var iconImage = menuImage?.getImage() {
            if  cellConfiguration.ignoreImageOriginalColor {
                iconImage = iconImage.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
            }
            iconImageView.tintColor = cellConfiguration.textColor
            iconImageView.frame =  CGRect(x: FT.DefaultCellMargin, y: (configuration.menuRowHeight - cellConfiguration.menuIconSize)/2, width: cellConfiguration.menuIconSize, height: cellConfiguration.menuIconSize)
            iconImageView.image = iconImage
            nameLabel.frame = CGRect(x: FT.DefaultCellMargin*2 + cellConfiguration.menuIconSize, y: (configuration.menuRowHeight - cellConfiguration.menuIconSize)/2, width: (configuration.menuWidth - cellConfiguration.menuIconSize - FT.DefaultCellMargin*3), height: cellConfiguration.menuIconSize)
        }
    }
}
