//
//  CreateLoginViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/9/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import Firebase

class CreateLoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmpasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButton1(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (register, error) in
                   
        //   Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let user = register?.user {
                
                print("\(user.email ?? "")")
                
            } else if let error = error {
                print("Create error: \(error)")
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "create"
        // Do any additional setup after loading the view.
        registerButton.layer.cornerRadius = 16
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
