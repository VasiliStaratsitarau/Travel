//
//  MapViewController.swift
//  Travel
//
//  Created by Vasili Staratsitarau on 8/23/20.
//  Copyright © 2020 TMS. All rights reserved.
//

import UIKit
import MapKit //подключается при работе с картами


class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var closure: ((CGPoint) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//            self.closure?(CGPoint(x: 100, y: 200))
//            self.navigationController?.popViewController(animated: true)
//        })
        // Do any additional setup after loading the view.
        mapView.addGestureRecognizer(longTapGesture)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func longTap(sender: UILongPressGestureRecognizer){
        if sender.state == .began {
           mapView.removeAnnotations(mapView.annotations)
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        let annotantion = MKPointAnnotation()
            annotantion.coordinate = locationOnMap
            
            mapView.addAnnotation(annotantion)
            let point = CGPoint(x: locationOnMap.latitude.rounded(2), y: locationOnMap.longitude.rounded(2))
            closure?(point)
        }
    }
}
extension Double {
    func rounded(_ number: Int) -> Double {
        let divisor = pow(10.0, Double(number))
        return(self * divisor).rounded() / divisor
    }
}
