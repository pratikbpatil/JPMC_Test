//
//  CustomTableViewCell.swift
//  JPMC_Pratik
//
//  Created by Pratik Patil on 18/05/23.
//

import UIKit

// Creating Custom TableViewCell
class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var planetNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
