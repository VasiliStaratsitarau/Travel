//
//  ViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/8/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig

class StartViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var anyloginButton: UIButton!
    
    
    override func viewDidLoad() {//срабатывает когда экран был загружен. Верстки еще нет.
        super.viewDidLoad()
       print("viewDidLoad")
        loginButton.layer.cornerRadius = 16
        createButton.layer.cornerRadius = 16
        
        let remoteConfig = RemoteConfig.remoteConfig()
        let loginText = remoteConfig["loginButtonText"].stringValue
        loginButton.setTitle(loginText, for: .normal)
        
        let isNeedToShowLoginButton = remoteConfig["isNeedToShowLoginButton"].boolValue
        if isNeedToShowLoginButton == false {
            loginButton.isHidden = true
        }
    }
    
    @IBAction func createTapLoginButton(_ sender: Any) {
        
        if let vc = UIStoryboard(name: "CreateLogin", bundle: nil).instantiateViewController(identifier: "CreateLoginViewController") as? CreateLoginViewController {
                   if let nav = navigationController {
                       nav.pushViewController(vc, animated: true)
                    
                   }
           
               }
    }
    
    
    
    @IBAction func actionTapLoginButton(_ sender: Any) {
        
        
        if let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            if let nav = navigationController {
                nav.pushViewController(vc, animated: true)
            }
        }
    }
}

/*override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear")
}
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear")
}
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear")
}
override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    print("viewDidDisappear")
}
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    print("viewDidLayoutSubviews")
}
*/
