//
//  FTExtension.swift
//  FTPopOverMenuDemo
//
//  Created by danxiao2 on 2018/6/1.
//  Copyright © 2018年 chquanquan. All rights reserved.
//

import UIKit

public protocol Imageable {
    func getImage() -> UIImage?
}

extension String: Imageable {
    public func getImage() -> UIImage? {
        return UIImage(named: self)
    }
}

extension UIImage: Imageable {
    public func getImage() -> UIImage? {
        return self
    }
}


