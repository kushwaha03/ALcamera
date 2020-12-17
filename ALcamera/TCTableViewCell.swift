//
//  TCTableViewCell.swift
//  ALcamera
//
//  Created by Krishna Kushwaha on 16/12/20.
//

import UIKit

class TCTableViewCell: UITableViewCell {

    @IBOutlet weak var headerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
