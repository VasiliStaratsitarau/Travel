//
//  LoadingViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 10/22/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class LoadingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.setValue("purple", forKey: "themeColorKey")
        
        let value = UserDefaults.standard.value(forKey: "themeColorKey")
        print("Saved value:", value)
        //
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate(completionHandler: { [weak self] (status, error) in
            DispatchQueue.main.async { [weak self] in
                if (Auth.auth().currentUser?.uid) != nil {
                    guard let self = self else {return}
                    self.showTravelList()
                } else {

                guard let self = self else {return}
                self.showWelcomeScreen()
                }
//               let controller =  XibViewController()
//                self?.navigationController?.pushViewController(controller, animated: true)
//
            }
        })
    }
    
    func showWelcomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC = storyboard.instantiateViewController(identifier: "StartViewController") as! StartViewController
        navigationController?.pushViewController(welcomeVC, animated: true)
        
    }
    

func showTravelList() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let welcomeVC = storyboard.instantiateViewController(identifier: "TravelListViewController") as! TravelListViewController
           navigationController?.pushViewController(welcomeVC, animated: true)
           
}
}
