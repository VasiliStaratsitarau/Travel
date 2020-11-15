//
//  PlacesViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 9/3/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit

protocol PlacesViewControllerDelegate {
    func addPlace(stop: Stop)
}

class PlacesViewController: UIViewController {
    
    var travel: Travel? = nil
    var transferText: String = ""
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Остановка"
        // navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(create))
        
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "save", style: .plain, target: self, action: #selector(save))
        // tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
       
    }
}
extension PlacesViewController: UITableViewDelegate,  UITableViewDataSource, PlacesViewControllerDelegate {
    
    
    func addPlace(stop: Stop) {
        travel?.stops.append(stop)
        tableView.reloadData()
        DatabaseManager.shared.saveTravelInDatabase(travel!)
    }
    func didUpdate(stop: Stop) {
        DatabaseManager.shared.saveTravelInDatabase(travel!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel?.stops.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesTableViewCell") as! PlacesTableViewCell
        let stop = travel?.stops[indexPath.row]
        cell.city.text = stop?.name ?? ""
        cell.about.text = stop?.desc ?? ""
        cell.money.text = String(stop?.spentMoney ?? 0)
        cell.currencyValue.text = stop?.currency.rawValue
      //  cell.transport.image = stop?.transport.rawValue.
      
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
  
       
    @objc
    func save() {
        
        //self.tableView.reloadData()
        navigationController?.popViewController(animated: true)
       
    }
    
    @objc
    func create(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "CreateCountry", bundle: nil)
        let createVC = storyboard.instantiateViewController(identifier: "CreateCountryViewController") as! CreateStopViewController
        createVC.delegate = self
        createVC.placesViewController = self
        createVC.travelId = travel?.id ?? ""
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CreateCountry", bundle: nil)
        let createVC = storyboard.instantiateViewController(identifier: "CreateCountryViewController") as! CreateStopViewController
        createVC.delegate = self
        createVC.placesViewController = self
        createVC.travelId = travel?.id ?? ""
        createVC.stop = travel?.stops[indexPath.row]
        
        navigationController?.pushViewController(createVC, animated: true)
    }
    
   
  
   // delegate?.update(stop:stop)
    
   
    
    // Do any additional setup after loading the view.
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


