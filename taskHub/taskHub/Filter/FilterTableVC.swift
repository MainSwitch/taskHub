//
//  FilterTableVC.swift
//  taskHub
//
//  Created by Anton on 20.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class FilterTableVC: UITableViewController {
    
    private let array = ["Новая","В процессе","Выполнено"]
    private let defaults = UserDefaults(suiteName: "group.myHub")
    
    var mySelect = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filtre", for: indexPath) as! FiltreCell
        
        cell.name.text = array[indexPath.row]
        if cell.name.text == Defaults[.filter]{
            cell.name.textColor = UIColor.green
        }else{
            cell.name.textColor = UIColor.black
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FiltreCell
        Defaults[.filter] = cell.name.text!
        if cell.name.textColor == UIColor.green{
            cell.name.textColor = UIColor.black
            Defaults[.filter] = ""
        }else{
            cell.name.textColor = UIColor.green
        }
        mySelect = indexPath
        tableView.reloadData()
    
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FiltreCell
        cell.name.textColor = UIColor.black
        tableView.reloadData()
    }
}
