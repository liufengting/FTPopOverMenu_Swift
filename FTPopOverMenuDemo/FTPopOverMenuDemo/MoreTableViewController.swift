//
//  MoreTableViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 18/11/2016.
//  Copyright © 2016 LiuFengting (https://github.com/liufengting) . All rights reserved.
//

import UIKit
import FTPopOverMenu_Swift

class MoreTableViewController: UITableViewController, MoreTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var menuOptionNameArray : [String] {
        return ["Share","Delete","Upload","Download","Share", "Share","Delete","Upload","Download","Share", "Share","Delete","Upload","Download","Share", "Share","Delete","Upload","Download","Share"]
    }
    
    var menuImageNameArray : [String] {
        return ["Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04","Pokemon_Go_01", "Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04","Pokemon_Go_01", "Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04","Pokemon_Go_01","Pokemon_Go_01","Pokemon_Go_02","Pokemon_Go_03","Pokemon_Go_04","Pokemon_Go_01"]
    }
    
    var selectedIndex : NSInteger = 0
    
    
    // MARK: - handle UIBarButtonItem tapped
    @IBAction func handleAddBarButtonItem(_ sender: UIBarButtonItem, event: UIEvent) {
        
        let menuModelArray : [FTPopOverMenuModel] = [FTPopOverMenuModel(title: "Share", image: "Pokemon_Go_01", selected: self.selectedIndex == 0),
                                                     FTPopOverMenuModel(title: "Delete", image: "Pokemon_Go_02", selected: self.selectedIndex == 1),
                                                     FTPopOverMenuModel(title: "Upload", image: "Pokemon_Go_03", selected: self.selectedIndex == 2),
                                                     FTPopOverMenuModel(title: "Download", image: "Pokemon_Go_04", selected: self.selectedIndex == 3),
                                                     FTPopOverMenuModel(title: "Share", image: "Pokemon_Go_01", selected: self.selectedIndex == 4)]
        
        let config = FTConfiguration()
        config.selectedTextColor = UIColor.red
        config.selectedCellBackgroundColor = UIColor.yellow
        
        
        FTPopOverMenu.showForEvent(event: event,
                                   with: menuModelArray,
                                   config: config,
                                   done: { (selectedIndex) -> () in
                                    self.selectedIndex = selectedIndex
        },
                                   cancel: {
                                    
        })
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MoreTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MoreCellIdentifier", for: indexPath) as! MoreTableViewCell
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - MoreTableViewCellDelegate
    
    func moreTableViewCellDidTappedButton(sender: UIButton) {
        
//        FTPopOverMenu.showFromSenderFrame(senderFrame: sender.frame,
//                                          with: ["Share"],
//                                          done: { (selectedIndex) -> () in
//                                            
//        }) {
//            
//        }

        FTPopOverMenu.showForSender(sender: sender,
                                    with: menuOptionNameArray,
                                    menuImageArray: menuImageNameArray,
                                    done: { (selectedIndex) -> () in
                              
                                        print(selectedIndex)

        }) {
            
        }
        
    }

}
