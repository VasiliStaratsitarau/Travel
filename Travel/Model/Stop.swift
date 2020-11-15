//
//  Stop.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/27/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import RealmSwift

enum Transport: Int, RealmEnum {
    case none, car, air, train
}

class Stop { //: CustomStringConvertible
    var travelId: String
    var id: String
    var name: String = ""
    var rating: Int = 0
    var location:  CGPoint = .zero //начало координат 0 0 CGPoint
    var spentMoney: Double = 0
    var currency: Currency = .none
    var transport: Transport = .none
    var desc: String = ""
    init(travelId: String, id: String) {
        self.id = id
        self.travelId = travelId
    }

    var json: [String: Any] {
        return ["id" : id,
                "travelId": travelId,
            "name": name ,
                "rating": rating,
                "location": "\(location.x)-\(location.y)",
                "spentMoney": spentMoney,
                "transport": transport.rawValue ,
                "currency": currency.rawValue,
                "desc": desc]
        
    }
}
