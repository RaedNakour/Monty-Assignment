//
//  LaunchViewModel.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import Foundation

struct LaunchViewModel{
    
    let launchID: String
    let launchName: String
    let launchDate: String
    let launchStatus:String
    let launchDetails: String
    let launchRocketID: String
    let launchFlightNumber: Int
    
    init(launch: Launches) {
        self.launchID = launch.launchID!
        self.launchName = launch.launchName!
        self.launchStatus = launch.launchStatus!
        self.launchRocketID = launch.launchRocketID!
        self.launchFlightNumber = launch.launchFlightNumber!
        
        //set details according to data
        if launch.launchDetails == nil {
            launchDetails = "No Details Available"
        }
        else{
            launchDetails = launch.launchDetails!
        }
        
        //parse iso date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let parsedDate = dateFormatter.date(from:launch.launchDate!)!
        //parse changed date
        let launchDate = DateFormatter.dateTimeSeconds.string(from: parsedDate)
        //set date
        self.launchDate = launchDate
        
    }
}

