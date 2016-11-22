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
        let menu = ["123","234","345","456","567","678","789","890"]
        FTPopOverMenu.showForSender(sender: sender, with: menu, done: { (selectedIndex) -> () in
            
        }) {
            
        }
    }
    
    @IBAction func handleNavgationBarButtonTap(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event, with: ["123","234","345","456","567","678","789","890"], done: { (selectedIndex) -> () in
            
        }) {
            
        }
    }
    
    
    @IBAction func handleBarButtonItemTap(_ sender: UIBarButtonItem, event: UIEvent) {
        FTPopOverMenu.showForEvent(event: event, with: ["123","234","345","456","567","678","789","890"], done: { (selectedIndex) -> () in
            
        }) {
            
        }
        
    }
    
    
    


}

