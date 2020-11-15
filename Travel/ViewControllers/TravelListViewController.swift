//
//  TravelListViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/9/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import RealmSwift


class TravelListViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    //MARK: - Properties
    var travels: [Travel] = []
    var travelsNotification: NotificationToken!
    
    //MARK - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let travelObjects = DatabaseManager.shared.getObjects(classType: RLMTravel.self)
        let stopObjects = DatabaseManager.shared.getObjects(classType: RLMStop.self)
        
        observeTravels()
        travels = DatabaseManager.shared.getTravels()
        getTravelsFromServer()
        getStopsFromServer()
        navigationItem.title = "Путешествия"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addCountry))
        
      //  travels = DataService.getData()
        
        /*----------------------------*/
        tableView.delegate = self
        tableView.dataSource = self
        /*----------------------------*/
        let nib = UINib.init(nibName: "TravelXibCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TravelXibCell")
        // xib registration
    }
}
extension TravelListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelXibCell"/*"TravelTableViewCell"*/) as! TravelXibCell //TravelTableViewCell
        
        let travel = travels[indexPath.row]
        cell.country.text = travel.name
        cell.about.text = travel.description
        for i in 0 ..< travel.avarageRating {
            cell.star[i].isHighlighted = true
            
        }
        
        return cell
        
    }
    //MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    //MARK: - EDIT/DELETE module
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [editAction])
        
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
        })
        deleteAction.backgroundColor = .red
        self.travels.remove(at: indexPath.row)
        self.tableView.reloadData()
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //============================
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "Places", bundle: nil)
        let stopsVC = storyboard.instantiateViewController(identifier: "Places") as! PlacesViewController
        let travel = travels[indexPath.row]
        stopsVC.travel = travel
        navigationController?.pushViewController(stopsVC, animated: true)
    }
    
    @objc
    func addCountry(_ sender: UIButton){
        let alertController = UIAlertController(title: "Add New Country", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Country"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            guard let firstTextField = alertController.textFields?[0].text else { return }
            guard let secondTextField = alertController.textFields?[1].text else { return }
            let id = UUID().uuidString
            let userId = Auth.auth().currentUser?.uid
            let travel = Travel(userId: userId ?? "", id: id, name: firstTextField, description: secondTextField)
            self.travels.insert(travel, at: 0)
            self.tableView.reloadData()
            self.sendToServer(travel: travel)
            DatabaseManager.shared.saveTravelInDatabase(travel)
            
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "About"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK: - Functions
    func getTravelsFromServer() {
        let database = Database.database().reference()
        database.child("travels").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self else {return}
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            DatabaseManager.shared.clear()
            self.travels.removeAll()
            //print(value.values)observeSingleEvent
            for item in value.values {
                if let travelJson = item as? [String: Any] {
                    if let id = travelJson["id"] as? String,
                        let name = travelJson["name"] as? String,
                        let description = travelJson["description"] as? String,
                        let userId = Auth.auth().currentUser?.uid {
                        let travel = Travel(userId: userId, id: id, name: name, description: description)
                        self.travels.append(travel)
                        self.tableView.reloadData()
                        //self.sendToServer(travel: travel)
                    }
                    
                }
            }
        }
    }
    
    func sendToServer(travel: Travel) {
        let database = Database.database().reference()
        let child = database.child("travels").child("\(travel.id)")
        child.setValue(travel.json) { (error, ref) in
            print(error as Any, ref)
            
        }
    }
    
    func getStopsFromServer() {
        let database = Database.database().reference()
        database.child("stops").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self else {return}
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            for item in value.values {
                if let stopJson = item as? [String: Any] {
                    if let id = stopJson["id"] as? String,
                        let travelId = stopJson["travelId"] as? String {
                        let stop = Stop(travelId: "", id: id)
                        
                        if let name = stopJson["name"] as? String {
                            stop.name = name
                        }
                        if let desc = stopJson["desc"] as? String {
                            stop.desc = desc
                        }
                        if let rating = stopJson["rating"] as? Int {
                            stop.rating = rating
                            
                        }
                        if let locationString = stopJson["location"] as? String {
                            let components = locationString.components(separatedBy: "-")
                            if let xpString = components.first,
                                let ypString = components.last,
                                let xp = Double(xpString),
                                let yp = Double(ypString)
                                //                            let x = Double(components.first!)!
                                //                            let y = Double(components.last!)!
                            {
                                stop.location = CGPoint(x: xp , y: yp)
                            }
                        }
                        if let transportInt = stopJson["transport"] as? Int,
                            let transport = Transport(rawValue: transportInt){
                            stop.transport = transport
                        }
                        if let currencyString = stopJson["currency"] as? String,
                            let currency = Currency(rawValue: currencyString) {
                            stop.currency = currency
                        }
                        //var travel: Travel?
                        for travel in self.travels {
                            if travel.id == travelId {
                                travel.stops.append(stop)
                            }
                        }
                    }
                }
            }
            DatabaseManager.shared.clear()
            for travel in self.travels {
                DatabaseManager.shared.saveTravelInDatabase(travel)
            }
        }
    }
    
    func observeTravels() {
        let realm = try! Realm()
        let travels = realm.objects(RLMTravel.self)
        travelsNotification = travels.observe { [weak self] (changes) in
            // guard let self = self else {return}
            switch changes {
            case .initial(_):
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("Did update Travels!")
            case .error(_):
                break
            }
        }
    }
}



