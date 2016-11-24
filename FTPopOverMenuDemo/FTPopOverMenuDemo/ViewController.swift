//
//  ViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 16/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var menuOptionNameArray : [String] = ["Share","Delete","Upload","Download"]

    var menuOptionImageNameArray : [String] = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
    

    // MARK: -  handle nornal button
    @IBAction func handleButtonTap(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            print(selectedIndex)
        }) {
            
        }
    }
    
    // MARK: -  handle NavgationBarButtonItem
    @IBAction func handleNavgationBarButtonTap(_ sender: UIBarButtonItem, event: UIEvent) {
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            print(selectedIndex)
        }) {
            
        }
    }
    
    // MARK: -  handle normal UIBarButtonItem
    @IBAction func handleBarButtonItemTap(_ sender: UIBarButtonItem, event: UIEvent) {
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            print(selectedIndex)
        }) {
            
        }
        
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
        config.textColor = UIColor.white
        config.backgoundTintColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        config.borderColor = UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        config.menuWidth = 120
        config.menuSeparatorColor = UIColor.lightGray
        config.textAlignment = .left
        config.textFont = UIFont.systemFont(ofSize: 14)
        config.menuRowHeight = 40
        config.cornerRadius = 6
    }
    
    func changeToWeChatStyle() {
        
        self.menuOptionImageNameArray = []
        
        
        let config = FTConfiguration.shared
        config.textColor = UIColor.black
        config.backgoundTintColor = UIColor.white
        config.borderColor = UIColor.lightGray
        config.menuWidth = 80
        config.menuSeparatorColor = UIColor.lightGray
        config.textAlignment = .center
        config.textFont = UIFont.systemFont(ofSize: 14)
        config.menuRowHeight = 40
        config.cornerRadius = 6

    }
    
    func changeToQQStyle() {
        
        menuOptionImageNameArray = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
        
        
        let config = FTConfiguration.shared
        config.textColor = UIColor.black
        config.backgoundTintColor = UIColor(white: 0.97, alpha: 1)
        config.borderColor = UIColor.white
        config.menuWidth = 150
        config.menuSeparatorColor = UIColor.lightGray
        config.textAlignment = .left
        config.textFont = UIFont.systemFont(ofSize: 16)
        config.menuRowHeight = 50
        config.cornerRadius = 20

        
    }
    
    func changeToMoreStyle() {
        
        menuOptionImageNameArray = ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
        
        
        let config = FTConfiguration.shared
        config.textColor = UIColor.white
        config.backgoundTintColor = UIColor.red
        config.borderColor = UIColor.red
        config.menuWidth = 120
        config.menuSeparatorColor = UIColor.white
        config.textAlignment = .left
        config.textFont = UIFont.systemFont(ofSize: 14)
        config.menuRowHeight = 40
        config.cornerRadius = 10
    }
    
}

