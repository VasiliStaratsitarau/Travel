//
//  RLMTravel.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 11/2/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import Foundation
import RealmSwift



class RLMTravel: Object {
    @objc dynamic  var id: String = ""
    @objc dynamic  var userId: String = ""
    @objc dynamic  var name: String = ""
    @objc dynamic  var desc: String = ""
    let stops = List<RLMStop>()
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMTravel.id)
    }
}

class RLMStop: Object {
    @objc dynamic   var travelId: String = ""
    @objc dynamic  var id: String = ""
    @objc dynamic  var name: String = ""
    @objc dynamic  var rating: Int = 0
    @objc dynamic  var latitude: Double = 0
    @objc dynamic  var langetude: Double = 0
   // @objc dynamic  var location:  CGPoint =  .zero //начало координат 0 0 CGPoint
    @objc dynamic  var spentMoney: Double = 0
    dynamic  var currency: Currency = .none
    dynamic  var transport: Transport = .none
    @objc dynamic  var desc: String = ""
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMStop.id)
    }
}

extension RLMTravel {
    func toObject() -> Travel {
        let travel = Travel(userId: self.userId,
                            id: self.id,
                            name: self.name,
                            description: self.desc)
        
        for rlmStop in self.stops {
            let stop = Stop(travelId: rlmStop.travelId, id: rlmStop.id)
            stop.name = rlmStop.name
            stop.rating = rlmStop.rating
            stop.location = CGPoint(x: rlmStop
                .latitude, y: rlmStop.langetude)
            stop.spentMoney = rlmStop.spentMoney
            stop.currency = rlmStop.currency
            stop.transport = rlmStop.transport
            stop.desc = rlmStop.desc
            travel.stops.append(stop)
        }
        return travel
    }
}
