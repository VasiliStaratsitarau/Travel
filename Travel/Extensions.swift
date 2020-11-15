//
//  Extensions.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/29/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerRad(value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
    
}
