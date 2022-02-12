//
//  RocketViewModel.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import Foundation

struct RocketViewModel {
    
    let rocketID: String
    let rocketName: String
    let rocketDetails: String
    let rocketWikipediaLink: URL
    let rocketImages: [URL]
    
    init(rocket: Rocket) {
        self.rocketID = rocket.rocketID!
        self.rocketName = rocket.rocketName!
        self.rocketDetails = rocket.rocketDetails!
        self.rocketWikipediaLink = rocket.rocketWikipediaLink!
        self.rocketImages = rocket.rocketImages!
    }
    
}
