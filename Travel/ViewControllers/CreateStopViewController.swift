//
//  CreateCountryViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/22/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol CreateCountryViewControllerDelegate: class {
    func update(text: String, currency: Currency)
}

class CreateStopViewController: UIViewController, CreateCountryViewControllerDelegate /*UINavigationControllerDelegate*/ {
    var placesViewController: PlacesViewController?
    
    @IBOutlet weak var cityLabel: UITextField!
    @IBOutlet weak var transportSelector: UISegmentedControl!
    @IBOutlet weak var totalMoney: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var moneyValue: UIButton!
    @IBOutlet weak var rateSelector: UIStepper!
    
    @IBOutlet weak var commentsText: UITextView!
    @IBOutlet weak var rateValue: UILabel!
    
    @IBAction func rateSelectorAct(_ sender: UIStepper) {
        rateValue.text = Int(sender.value).description
    }
    
    @IBAction func mapClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Map", bundle: nil)
        let mapVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(mapVC, animated: true)
        mapVC.closure = { point in
            self.locationLabel.text = "\(point.x)-\(point.y)"
            self.selectedLocation = point
        }
        
    }
    @IBAction func moneyValueAct(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Money", bundle: nil).instantiateViewController(identifier: "SpentMoneyViewController") as? SpentMoneyViewController {
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
   
    
    var travelId: String = ""
    var stop: Stop?
    var transport: Transport = .none
    var delegate: PlacesViewControllerDelegate?
    var currency: Currency = .none
    var selectedLocation: CGPoint = .zero
    var spentMoney: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transportSelector.addTarget(self, action: #selector(tapTransport), for: .valueChanged)
        //------------Selector Rate Action-------------//
        rateSelector.wraps = true
        rateSelector.autorepeat = true
        rateSelector.maximumValue = 5
        //-----------Select money value Action----------//
        
        
        navigationItem.title = "Остановка"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        
        if let stop = stop {
            cityLabel.text = stop.name
            rateValue.text = "\(stop.rating)"
            totalMoney.text = "\(stop.spentMoney)\(stop.currency.rawValue)"
            currency = stop.currency
            transport = stop.transport
            commentsText.text = stop.desc
            locationLabel.text = "\(stop.location.x)-\(stop.location.y)"
            selectedLocation = stop.location
            //DOPISAT±!!!!!!!!!!
        }
    }
    
    
    func update(text: String, currency: Currency) {
        self.totalMoney.text = "\(text)\(currency.rawValue)"
        self.currency = currency
        self.spentMoney = Double(text) ?? 0
    }
    
    @objc
    func save() {
        if let stop = stop {
            update(stop: stop)
            
            sendToServer(stop: stop)
            placesViewController?.tableView.reloadData()
            
             
        } else {
            let id = UUID().uuidString
            let stop = Stop(travelId: travelId, id: id)
            update(stop: stop)
            sendToServer(stop: stop)
            delegate?.addPlace(stop: stop)
            
        }
        
    }
    
  
    func update(stop: Stop) {
        stop.name = cityLabel.text ?? ""
        stop.rating = Int(rateValue!.text ?? "") ?? 0
       
        stop.location = selectedLocation
        stop.desc = commentsText.text
        stop.spentMoney = spentMoney
        stop.currency = currency
    }
    
    @objc
    func tapTransport() {
        if transportSelector.selectedSegmentIndex == 0 {
            transport = .car
        } else if transportSelector.selectedSegmentIndex == 1 {
            transport = .air
        } else if transportSelector.selectedSegmentIndex == 2 {
            transport = .train
        }
    }
    
    func sendToServer(stop: Stop) {
        let database = Database.database().reference()
        let child = database.child("stops").child("\(stop.id)")
        child.setValue(stop.json) { [weak self] (error, ref) in
            print(error as Any, ref)
             guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        }
    
    }
    
    
}
