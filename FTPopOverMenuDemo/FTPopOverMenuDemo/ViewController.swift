//
//  ViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 16/11/2016.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift

enum MenuStyle {
    case normal
    case qq
    case wechat
    case more
}

class ViewController: UIViewController {
    
    var menuStyle : MenuStyle = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var menuOptionNameArray = ["Share", "Delete", "Upload", "Download"]
    
    func configWithMenuStyle() -> FTConfiguration {
        let config = FTConfiguration()
        switch self.menuStyle {
        case .normal: break
        case .wechat:
            config.backgoundTintColor = UIColor.white
            config.borderColor = UIColor.lightGray
            config.menuWidth = 80
            config.menuSeparatorColor = UIColor.lightGray
            config.menuRowHeight = 40
            config.cornerRadius = 6
            config.textColor = UIColor.black
            config.textAlignment = NSTextAlignment.center
        case .qq:
            config.backgoundTintColor = UIColor(white: 0.90, alpha: 1)
            config.borderColor = UIColor.white
            config.menuWidth = 150
            config.menuSeparatorColor = UIColor.lightGray
            config.menuRowHeight = 50
            config.cornerRadius = 20
            config.textColor = UIColor.black
        case .more:
            config.backgoundTintColor = UIColor.red
            config.borderColor = UIColor.red
            config.menuWidth = 120
            config.menuSeparatorColor = UIColor.white
            config.menuRowHeight = 40
            config.cornerRadius = 10
        }
        return config
    }
    
    func menuOptionImageNameArrayWithMenuArray() -> [UIImage] {
        if self.menuStyle == .wechat {
            return []
        }
        return [#imageLiteral(resourceName: "Pokemon_Go_01"), #imageLiteral(resourceName: "Pokemon_Go_02"), #imageLiteral(resourceName: "Pokemon_Go_03"), #imageLiteral(resourceName: "Pokemon_Go_04")]
    }
    
    // MARK: -  handle nornal button
    @IBAction func handleButtonTap(_ sender: UIButton) {
        
//        FTPopOverMenu.showForSender(sender: sender, with: menuOptionNameArray) { (selectedIndex) in }
        
        FTPopOverMenu.showForSender(sender: sender,
                                    with: menuOptionNameArray as [AnyObject],
                                    menuImageArray: self.menuOptionImageNameArrayWithMenuArray(),
                                    config: self.configWithMenuStyle(),
                                    done: { (selectedIndex) in
                                        print(selectedIndex)
        },
                                    cancel: {
                                        print("cancel")
        })
        
    }
    
    // MARK: -  handle NavgationBarButtonItem
    @IBAction func handleNavgationBarButtonTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event,
                                   with: menuOptionNameArray as [AnyObject],
                                   menuImageArray: self.menuOptionImageNameArrayWithMenuArray(),
                                   config: self.configWithMenuStyle(),
                                   done: { (selectedIndex) in
                                    print(selectedIndex)
        },
                                   cancel: {
                                    
        })
        
    }
    
    // MARK: -  handle normal UIBarButtonItem
    @IBAction func handleBarButtonItemTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event,
                                   with: menuOptionNameArray as [AnyObject],
                                   menuImageArray: self.menuOptionImageNameArrayWithMenuArray(),
                                   config: self.configWithMenuStyle(),
                                   done: { (selectedIndex) in
                                    print(selectedIndex)
        })
        
    }
    
    // MARK: -  handle style change
    @IBAction func handleStyleChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.menuStyle = .normal
        case 1:
            self.menuStyle = .wechat
        case 2:
            self.menuStyle = .qq
        case 3:
            self.menuStyle = .more
        default:
            break
        }
    }
    
}

