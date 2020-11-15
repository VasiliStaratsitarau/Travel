//
//  Model.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/9/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import Foundation

//struct Country {
//    let name: String?
//    let description: String?
//    let places: [Place?]
//}
//
//struct Place {
//    var name: String?
//}

class Travel {
    var userId: String
    var id: String
    var name: String
    var description: String
    var stops: [Stop] = []
    
    init(userId: String, id: String, name: String, description: String) {
        self.userId = userId
        self.id = id
        self.name = name
        self.description = description
        
    }
    
    var avarageRating: Int{
        guard stops.count > 0 else {
            return 0
        }
        var sum = 0
        for stop in stops {
            sum += stop.rating
        }
        return sum/stops.count
    }
    func getAvarageRating() -> Int {
        guard stops.count > 0 else {return 0}
        var sum = 0
        for stop in stops {
            sum += stop.rating
        }
        return sum/stops.count
    }
 
    var json: [String: Any] {
        return ["id": id, "name": name ,
                "description": description
               // , "stops": stops.map({ $0.json })
        ]
        
    }
}
extension Travel {
    func toRealm() -> RLMTravel {
        let rlmTravel = RLMTravel()
        rlmTravel.name = self.name
        rlmTravel.desc = self.description
        rlmTravel.id = self.id
        rlmTravel.userId = self.userId
        for stop in self.stops {
            let rlmStop = RLMStop()
            rlmStop.id = stop.id
            rlmStop.travelId = stop.travelId
            rlmStop.name = stop.name
            rlmStop.rating = stop.rating
            rlmStop.latitude = Double(stop.location.x)
            rlmStop.langetude = Double(stop.location.y)
            rlmStop.spentMoney = stop.spentMoney
            rlmStop.currency = stop.currency
            rlmStop.transport = stop.transport
            rlmStop.desc = stop.desc
            rlmTravel.stops.append(rlmStop)
        }
        return rlmTravel
    }
}
