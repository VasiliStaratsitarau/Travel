//
//  LoginViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/8/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
//outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
   @IBOutlet weak var loginButton: UIButton!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        loginButton.cornerRad(value: 16)
        //loginButton.cornerRadius()
        super.viewDidLoad()
           print("viewDidLoad")
           
        }
//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            print("viewWillAppear")
//        }
//        override func viewDidAppear(_ animated: Bool) {
//            super.viewDidAppear(animated)
//            print("viewDidAppear")
//        }
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            print("viewWillDisappear")
//        }
//        override func viewDidDisappear(_ animated: Bool) {
//            super.viewDidDisappear(animated)
//            print("viewDidDisappear")
//        }
//        override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            print("viewDidLayoutSubviews")
//    }
//    deinit {
//        print("deinit")
//    }
    
    @IBAction func actionTapLoginButton(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
         Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            
            if let user = result?.user {
                print("User успешно  залогинился \(user.email ?? "")")
                 
             } else if let error = error {
                guard let self = self else {return}
                self.emailTextField.layer.borderColor = UIColor.red.cgColor
                self.passwordTextField.layer.borderColor = UIColor.red.cgColor
                //self.activityIndicator.stopAnimating()
                return
                 print("Create error: \(error)")
             }
         }
        //Auth
        if let vc = UIStoryboard(name: "TravelList", bundle: nil).instantiateViewController(identifier: "TravelListViewController") as? TravelListViewController {
            if let nav = navigationController {
                
                nav.pushViewController(vc, animated: true)
                
            }
        }
        
    }
    
    @IBAction func ActionTapForgotButton(_ sender: Any) {
        if let vc = UIStoryboard(name: "Forgot", bundle: nil).instantiateViewController(identifier: "ForgotViewController") as? ForgotViewController {
            if let nav = navigationController {
                
                nav.pushViewController(vc, animated: true)
                
            }
        }

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
