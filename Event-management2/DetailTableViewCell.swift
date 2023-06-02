//
//  DetailTableViewCell.swift
//  Event-management2
//
//  Created by Akanksha Pakhale on 28/05/23.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    //MARK: - IBoutlets for detail cell
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblsubtitle: UILabel!
    @IBOutlet weak var myimage: UIImageView!
    @IBOutlet weak var lblcategory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
