//
//  MoneyViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/23/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import RealmSwift

enum Currency: String, RealmEnum {
    case none = ""
    case ruble = "₽"
    case euro = "€"
    case dollar = "$"
}
class SpentMoneyViewController: UIViewController {
    //MARK: - Properties
    
    weak var delegate: CreateCountryViewControllerDelegate?
   var currency = Currency.none
    //MARK: - Outlets
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var money: UISegmentedControl!
    @IBOutlet weak var totalMoney: UITextField!
    //MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ok.layer.cornerRadius = 16
        money.addTarget(self, action: #selector(tapSegment), for: .valueChanged)
        
    }
    
    //MARK: - Actions
    @IBAction func okAction(_ sender: Any) {
        delegate?.update(text: totalMoney.text ?? "", currency: currency)
        navigationController?.popViewController(animated: true)
    }
   
    @objc
    func tapSegment() {
        if money.selectedSegmentIndex == 0 {
            currency = .dollar
            
        } else if money.selectedSegmentIndex == 1 {
            currency = .euro
            
        } else if money.selectedSegmentIndex == 2 {
            currency = .ruble
           
        }
    }
}
