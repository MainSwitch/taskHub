//
//  TaskCell.swift
//  taskHub
//
//  Created by Anton on 18.07.2018.
//  Copyright © 2018 Anton. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet var hed: UILabel!
    @IBOutlet var com: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var stat: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
