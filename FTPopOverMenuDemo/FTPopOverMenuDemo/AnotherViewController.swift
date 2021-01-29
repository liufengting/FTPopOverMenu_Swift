//
//  AnotherViewController.swift
//  FTPopOverMenuDemo
//
//  Created by Wincarn on 2021/1/22.
//  Copyright © 2021 LiuFengting. All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift

class AnotherViewController: UIViewController {

    var popOverMenu = FTPopOverMenu()
    
    var selectedIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        popOverMenu.showForSender(sender: sender, or: nil, with: ["a", "b"]) { (index) in
            self.selectedIndex = index
            print(index)
        }
    }
    
    @IBAction func anotherButton(_ sender: UIButton) {
        FTPopOverMenu.showForSender(sender: sender, with: ["a", "b"]) { (index) in
            self.selectedIndex = index
            print(index)
        }
    }
    
    deinit {
        print("deinit")
    }


}
