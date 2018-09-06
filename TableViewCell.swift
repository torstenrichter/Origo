//
//  TableViewCell.swift
//  Origo
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var projectName: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var hours: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
