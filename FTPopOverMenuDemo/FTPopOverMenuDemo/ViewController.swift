//
//  ViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 16/11/2016.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var menuOptionNameArray = ["Share", "Delete", "Upload", "Download"]
    
    var menuOptionImageNameArray = ["Pokemon_Go_01", "Pokemon_Go_02", "Pokemon_Go_03", "Pokemon_Go_04"]
    var menuOptionImageImageArray = [#imageLiteral(resourceName: "Pokemon_Go_01"), #imageLiteral(resourceName: "Pokemon_Go_02"), #imageLiteral(resourceName: "Pokemon_Go_03"), #imageLiteral(resourceName: "Pokemon_Go_04")]
    
    
    // MARK: -  handle nornal button
    @IBAction func handleButtonTap(_ sender: UIButton) {
        
        let cellConfi = FTCellConfiguration()
        cellConfi.textColor = UIColor.black
        cellConfi.textAlignment = .left
        cellConfi.textFont = UIFont.systemFont(ofSize: 14)
        var cellConfis = Array(repeating: cellConfi, count: 4)
        
        let cellConfi1 = FTCellConfiguration()
        cellConfi1.textColor = UIColor.black
        cellConfis[1] = cellConfi1
        
        FTPopOverMenu.showForSender(sender: sender, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, cellConfigurationArray: cellConfis, done: { (selectedIndex) in
            print(selectedIndex)
        }) {
            print("cancel")
        }
    }
    
    // MARK: -  handle NavgationBarButtonItem
    @IBAction func handleNavgationBarButtonTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: menuOptionImageImageArray, done: { (selectedIndex) in
            print(selectedIndex)
        }, cancel: nil)
    }
    
    // MARK: -  handle normal UIBarButtonItem
    @IBAction func handleBarButtonItemTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        let cellConfi = FTCellConfiguration()
        cellConfi.textColor = UIColor.blue
        cellConfi.textAlignment = .left
        cellConfi.textFont = UIFont.systemFont(ofSize: 14)
        let cellConfis = Array(repeating: cellConfi, count: 4)
        
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: nil, cellConfigurationArray: cellConfis, done: { (selectedIndex) in
            print(selectedIndex)
        })
        
    }
    
    // MARK: -  handle style change
    @IBAction func handleStyleChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.changeToNormalStyle()
        case 1:
            self.changeToWeChatStyle()
        case 2:
            self.changeToQQStyle()
        case 3:
            self.changeToMoreStyle()
        default:
            break
        }
        
    }
}

extension ViewController {
    
    
    
    func changeToNormalStyle() {
        
        menuOptionImageNameArray = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
        
        
        let config = FTConfiguration.shared
        config.backgoundTintColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        config.borderColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        config.menuWidth = 120
        config.menuSeparatorColor = UIColor.lightGray
        config.menuRowHeight = 40
        config.cornerRadius = 6
    }
    
    func changeToWeChatStyle() {
        
        self.menuOptionImageNameArray = []
        
        
        let config = FTConfiguration.shared
        config.backgoundTintColor = UIColor.white
        config.borderColor = UIColor.lightGray
        config.menuWidth = 80
        config.menuSeparatorColor = UIColor.lightGray
        config.menuRowHeight = 40
        config.cornerRadius = 6
        
    }
    
    func changeToQQStyle() {
        
        menuOptionImageNameArray = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
        
        let config = FTConfiguration.shared
        config.backgoundTintColor = UIColor(white: 0.97, alpha: 1)
        config.borderColor = UIColor.white
        config.menuWidth = 150
        config.menuSeparatorColor = UIColor.lightGray
        config.menuRowHeight = 50
        config.cornerRadius = 20
        
        
    }
    
    func changeToMoreStyle() {
        
        menuOptionImageNameArray = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
        
        
        let config = FTConfiguration.shared
        config.backgoundTintColor = UIColor.red
        config.borderColor = UIColor.red
        config.menuWidth = 120
        config.menuSeparatorColor = UIColor.white
        config.menuRowHeight = 40
        config.cornerRadius = 10
    }
    
}

