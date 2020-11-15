//
//  AlamofireViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 9/28/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://jsonplaceholder.typicode.com/users").responseJSON {
            (response) in
            self.textView.text = "\(response.value ?? "")"
        }
        AF.request("https://jsonplaceholder.typicode.com/posts",
                   method: .post, parameters: ["login": "vasii", "password": "122234214"]) .responseJSON { (response) in
                    self.textView.text = "\(response.value ?? "")"
        // Do any additional setup after loading the view.
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
