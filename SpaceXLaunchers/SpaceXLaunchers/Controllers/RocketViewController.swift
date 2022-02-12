//
//  RocketViewController.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import UIKit

class RocketViewController: UIViewController {
    
    @IBOutlet var rocketViewDetails: UIView!
    
    @IBOutlet var rocketName: UILabel!
    @IBOutlet var rocketDetails: UILabel!
    @IBOutlet var rocketDate: UILabel!
    
    
    var selectedLaunchDate:String?
    var selectedRocket:RocketViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adjustLayoutScreen()
    }
    
    
    func adjustLayoutScreen() {
        
        //set layout properties
        //set view rounded edges
        let path = UIBezierPath(roundedRect:rocketViewDetails.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 50,height: 50))
        let maskLayer = CAShapeLayer()

        maskLayer.path = path.cgPath
        rocketViewDetails.layer.mask = maskLayer
        
        //set rocket details
        rocketName.text = selectedRocket?.rocketName
        rocketDate.text = selectedLaunchDate
        rocketDetails.text = selectedRocket?.rocketDetails
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        //go back to previous vew controller
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func launchWikipedia(_ sender: Any) {
        //launch wikipedia from link
        if let url = selectedRocket?.rocketWikipediaLink {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    
    
    
}
