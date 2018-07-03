//
//  FTCellConfiguration.swift
//  FTPopOverMenuDemo
//
//  Created by danxiao2 on 2018/5/30.
//  Copyright © 2018年 chquanquan. All rights reserved.
//

import UIKit

public class FTCellConfiguration : NSObject {
    
    public var textColor : UIColor = UIColor.white
    public var textFont : UIFont = UIFont.systemFont(ofSize: 14)
    public var textAlignment : NSTextAlignment = NSTextAlignment.left
    public var ignoreImageOriginalColor = false
    public var menuIconSize : CGFloat = FT.DefaultMenuIconSize
    
}
