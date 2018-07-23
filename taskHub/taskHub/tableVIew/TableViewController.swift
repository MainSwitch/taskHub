//
//  TableViewController.swift
//  taskHub
//
//  Created by Anton on 18.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class TableViewController: UITableViewController {
private let defaults = UserDefaults(suiteName: "group.myHub")
private var filterArray = [Int]()
 
    @IBAction func delet(_ sender: Any) {
        defaults?.removeAll()
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Defaults.addSuite(named: "group.myHub")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        filterArray.removeAll()
        if !(Defaults[.filter].trimmingCharacters(in: .whitespaces).isEmpty){
            var i = 0
            while i < Defaults[.arrayHed].count{
                if Defaults[.filter] == defaults?.string(forKey: "status"+(Defaults[.arrayHed][i])) {
                    filterArray.append(i)
                }
                i += 1
            }
        }
        if (Defaults[.filter].trimmingCharacters(in: .whitespaces).isEmpty){
            return Defaults[.arrayHed].count
        }else{
            return filterArray.count
        }
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        let utilityQueue = DispatchQueue.global(qos: .utility)
        utilityQueue.sync {
        if (Defaults[.filter].trimmingCharacters(in: .whitespaces).isEmpty){
            cell.hed.text = Defaults[.arrayHed][indexPath.row]
            cell.com.text = Defaults[.arrayComent][indexPath.row]
            cell.date.text = Defaults[.arrayDate][indexPath.row]
            cell.stat.text = self.defaults?.string(forKey: "status"+(Defaults[.arrayHed][indexPath.row]))
        }else{
            cell.hed.text = Defaults[.arrayHed][self.filterArray[indexPath.row]]
            cell.com.text = Defaults[.arrayComent][self.filterArray[indexPath.row]]
            cell.date.text = Defaults[.arrayDate][self.filterArray[indexPath.row]]
            cell.stat.text = self.defaults?.string(forKey: "status" + (cell.hed.text)!)
            }
        if cell.stat.text == "Выполнено"{
            cell.stat.textColor = UIColor.green
        } else if cell.stat.text == "Новая"{
            cell.stat.textColor = UIColor.orange
        } else if cell.stat.text == "В процессе"{
            cell.stat.textColor = UIColor.blue
        }
        }
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        defaults?.synchronize()
        Defaults.synchronize()
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Defaults[.index] = indexPath.row
        Defaults[.indexStat] = Defaults[.arrayHed][indexPath.row]
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var i = indexPath.row
            if i+1 < Defaults[.arrayHed].count{
            while i <= Defaults[.arrayHed].count{
                
                let item = defaults?.string(forKey: "status"+(Defaults[.arrayHed][indexPath.row+1]))
                defaults?.removeObject(forKey: "status"+(Defaults[.arrayHed][indexPath.row]))
                defaults?.set(item, forKey: "status"+(Defaults[.arrayHed][indexPath.row]))
                i += 1
                }
                }else{
            defaults?.removeObject(forKey: "status"+(Defaults[.arrayHed][indexPath.row]))
            }
            Defaults[.arrayHed].remove(at: indexPath.row)
            Defaults[.arrayComent].remove(at: indexPath.row)
            Defaults[.arrayDate].remove(at: indexPath.row)
            defaults?.synchronize()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
}

