//
//  MoreTableViewController.swift
//  FTPopOverMenuDemo
//
//  Created by liufengting on 18/11/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit

class MoreTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return cell
    }


}
