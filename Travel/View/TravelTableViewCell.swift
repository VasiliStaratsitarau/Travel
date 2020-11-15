//
//  TravelTableViewCell.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/9/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
//MARK: - OUTLETS
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var about: UILabel!
   // @IBOutlet weak var rating: UILabel!
   // @IBOutlet weak var rating: UIStackView!
    
    @IBOutlet var star: [UIImageView]!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     //   cellView.layer.cornerRadius = 16
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
