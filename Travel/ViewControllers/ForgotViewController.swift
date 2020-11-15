//
//  ForgotViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/8/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit

class ForgotViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.title = "Forgot Password"
        
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

}
