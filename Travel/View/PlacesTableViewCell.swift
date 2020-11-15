//
//  PlacesTableViewCell.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 9/3/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit

class PlacesTableViewCell: UITableViewCell {

    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var money: UILabel!
    
    @IBOutlet weak var transport: UIImageView!
    @IBOutlet weak var currencyValue: UILabel!
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 16
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
