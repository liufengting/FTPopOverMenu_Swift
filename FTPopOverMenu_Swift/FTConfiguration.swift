//
//  FTConfiguration.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 28/07/2017.
//  Copyright © 2017 LiuFengting. All rights reserved.
//

import UIKit

public class FTConfiguration : NSObject {

    public var menuRowHeight : CGFloat = FT.DefaultMenuRowHeight
    public var menuWidth : CGFloat = FT.DefaultMenuWidth
    public var textColor : UIColor = UIColor.white
    public var textFont : UIFont = UIFont.systemFont(ofSize: 14)
    public var borderColor : UIColor = FT.DefaultTintColor
    public var borderWidth : CGFloat = FT.DefaultBorderWidth
    public var backgoundTintColor : UIColor = FT.DefaultTintColor
    public var cornerRadius : CGFloat = FT.DefaultCornerRadius
    public var textAlignment : NSTextAlignment = NSTextAlignment.left
    public var ignoreImageOriginalColor : Bool = false
    public var menuSeparatorColor : UIColor = UIColor.lightGray
    public var menuSeparatorInset : UIEdgeInsets = UIEdgeInsetsMake(0, FT.DefaultCellMargin, 0, FT.DefaultCellMargin)
    public var cellSelectionStyle : UITableViewCellSelectionStyle = .none

    public static var shared : FTConfiguration {
        struct StaticConfig {
            static let instance : FTConfiguration = FTConfiguration()
        }
        return StaticConfig.instance
    }

}
