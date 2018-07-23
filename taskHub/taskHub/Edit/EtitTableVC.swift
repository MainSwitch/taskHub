//
//  EtitTableVC.swift
//  taskHub
//
//  Created by Anton on 20.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit
import SelectPickerCell
import SwiftyUserDefaults

class EtitTableVC: UITableViewController {

    private let defaults = UserDefaults(suiteName: "group.myHub")
    private var selectCell = SelectPickerCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
    private let array = ["Новая","В процессе","Выполнено"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectCell.leftLabel.text = "Выберите статуc"
        selectCell.options = array
        selectCell.selectedOption = (defaults?.string(forKey: "status"+(Defaults[.indexStat]))!)!
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return selectCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return selectCell.selectPickerHeight()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        selectCell.selectedInTableView(tableView)
    }

}
