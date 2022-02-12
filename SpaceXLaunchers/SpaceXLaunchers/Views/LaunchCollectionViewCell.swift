//
//  LaunchCollectionViewCell.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import UIKit

class LaunchCollectionViewCell: UICollectionViewCell {
    @IBOutlet var launchID: UILabel!
    @IBOutlet var launchDate: UILabel!
    @IBOutlet var launchName: UILabel!
    @IBOutlet var launchStatus: UILabel!
    
    var launchViewModel: LaunchViewModel! {
        didSet{
            
            //fill cell data
            launchID?.text = String(launchViewModel.launchFlightNumber)
            launchDate?.text = launchViewModel.launchDate
            launchName?.text = launchViewModel.launchName
            launchStatus?.text = launchViewModel.launchStatus
            
        }
    }
    
}
