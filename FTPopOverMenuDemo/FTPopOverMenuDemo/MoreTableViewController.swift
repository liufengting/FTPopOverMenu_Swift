//
//  MoreTableViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 18/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController, MoreTableViewCellDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func handleAddBarButtonItem(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event,
                                   with: menuOptionNameArray,
                                   menuImageArray: menuOptionImageNameArray,
                                   done: { (selectedIndex) -> () in
                                    
        }) {
            
        }
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
    
    
    // MARK: - MoreTableViewCellDelegate
    
    func moreTableViewCellDidTappedButton(sender: UIButton) {
        
        FTPopOverMenu.showForSender(sender: sender,
                                    with: menuOptionNameArray,
                                    menuImageArray: menuOptionImageNameArray,
                                    done: { (selectedIndex) -> () in
                                        
        }) {
            
        }
        
    }

}
