//
//  SortBTableViewCell.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 30/05/23.
//

import UIKit

class SortBTableViewCell: UITableViewCell {
    //MARK: -  IBOutlets declaration
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblsubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
