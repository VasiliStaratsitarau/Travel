//
//  DatabaseManager.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 11/2/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    func saveTravelInDatabase(_ travel: Travel) {
        let rlmTravel = travel.toRealm()
        let realm = try! Realm() // создается объектик для работы с базой данных
        try! realm.write {
            realm.add(rlmTravel, update: .all)
        } // закрыли транзакцию
    }
    
    func getTravels() -> [Travel] {
        var result: [Travel] = []
        //        чтобы достать из реалма чтото надо создать объект реалма
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        for rlmTravel in rlmTravels {
            let travel = rlmTravel.toObject()
            result.append(travel)
        }
        return result
    }
    func clear() {
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        let rlmStops = realm.objects(RLMStop.self)
      
        try! realm.write {
        realm.delete(rlmTravels)
        realm.delete(rlmStops)
        }
    }
    func getObjects<T: Object>(classType: T.Type) -> [T] {
        var result: [T] = []
        let realm = try! Realm()
        let objects = realm.objects(T.self)
        for object in objects {
            result.append(object)
    }
    return result
}
}


