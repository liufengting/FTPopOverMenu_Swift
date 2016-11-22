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

    @IBAction func handleButtonTap(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            
        }) {
            
        }
    }
    
    @IBAction func handleNavgationBarButtonTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            
        }) {
            
        }
    }
    
    
    @IBAction func handleBarButtonItemTap(_ sender: UIBarButtonItem, event: UIEvent) {
        FTPopOverMenu.showForEvent(event: event, with: menuOptionNameArray, menuImageArray: menuOptionImageNameArray, done: { (selectedIndex) -> () in
            
        }) {
            
        }
        
    }
}

extension UIViewController {
    
    var menuOptionNameArray : [String] {
        return ["123","234","345","456"]
    }
    var menuOptionImageNameArray : [String] {
        return ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04"]
    }
    
}

