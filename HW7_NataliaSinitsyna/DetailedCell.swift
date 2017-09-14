//
//  DetailedCell.swift
//  HW7_NataliaSinitsyna
//
//  Created by Admin on 06.07.17.
//  Copyright © 2017 GB. All rights reserved.
//

import UIKit

class DetailedCell: UITableViewCell {

    @IBOutlet weak var labelDescr: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imagePng: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
