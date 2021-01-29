//
//  UIScreen+Frame.swift
//  FTPopOverMenu_Swift
//
//  Created by Abdullah Selek on 27/07/2017.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

extension UIScreen {
    
    public static func ft_width() -> CGFloat {
        return self.main.bounds.size.width
    }
    public static func ft_height() -> CGFloat {
        return self.main.bounds.size.height
    }
    
}
