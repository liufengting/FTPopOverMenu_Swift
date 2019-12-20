//
//  FTPopOverMenuModel.swift
//  FTPopOverMenu_Swift
//
//  Created by liufengting on 2019/12/20.
//  Copyright © 2019 LiuFengting. All rights reserved.
//

import UIKit

public class FTPopOverMenuModel: NSObject {
    
    public var title: String = ""
    public var image: Imageable?
    public var selected: Bool = false
    
    public convenience init(title: String, image: Imageable?, selected: Bool) {
        self.init()
        self.title = title
        self.image = image
        self.selected = selected
    }
    
}
