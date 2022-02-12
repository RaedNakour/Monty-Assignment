//
//  NetworkCalls.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import Alamofire
import SwiftyJSON


enum LaunchStatus:String {
    case Success = "Success"
    case Upcoming = "Upcoming"
}

protocol NetworkCalls {
    // fetch last 3 years launches
    func fetchLaunchesByDate(completionHandler:@escaping ([Launches]) -> Void)
    // fetch rocket details by id
    func fetchRocketByID(rocketID: String,completionHandler:@escaping (Rocket) -> Void)
}

extension NetworkCalls{
    // fetch launches for the last 3 years
    func fetchLaunchesByDate(completionHandler:@escaping ([Launches]) -> Void) {
        
        var fetchedLaunches = [Launches]()
        
        // set start and end dates
        let endDate = Date()
        let startDate = Calendar.current.date(byAdding: .year, value: -3, to: Date())!
        
        //set api parameters according to dates
        let parameters = [
            "query": [
                "date_utc": [
                    "$gte": DateFormatter.iso8601Full.string(from: startDate),
                    "$lte": DateFormatter.iso8601Full.string(from: endDate)
                ]
            ],
            "options": [
                "sort": [
                    "utc_date": "asc"
                ],
                "pagination": false
            ]
        ]
        
        
        let fetchURl = "https://api.spacexdata.com/v4/launches/query"
        let method: HTTPMethod = .post
        let headers: HTTPHeaders? = nil
        
        AF.request(fetchURl,method: method,parameters: parameters,encoding:JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            
            // fetched data
            let fetchedJson = try! JSON(data: response.data!)
            let launches = fetchedJson["docs"]
            
            //loop to save data in array of launches
            for index in 0..<launches.count{
                // check if launch is success
                if launches[index]["success"] == true ||
                   launches[index]["upcoming"] == true
                {
                    
                    //create instance of launch
                    var currentLaunch = Launches()
                    
                    currentLaunch.launchID = launches[index]["id"].string
                    currentLaunch.launchName = launches[index]["name"].string
                    currentLaunch.launchDate = launches[index]["date_local"].string
                    currentLaunch.launchDetails = launches[index]["details"].string
                    currentLaunch.launchRocketID = launches[index]["rocket"].string
                    currentLaunch.launchFlightNumber = launches[index]["flight_number"].int
                    //check launch status
                    launches[index]["upcoming"] == true
                    ? (currentLaunch.launchStatus = LaunchStatus.Upcoming.rawValue)
                    : (currentLaunch.launchStatus = LaunchStatus.Success.rawValue)
                    
                    //add instance of launch to the list
                    fetchedLaunches.append(currentLaunch)
                }
            }
            //return launches
            DispatchQueue.main.async {
                completionHandler(fetchedLaunches)
            }
            
        }.resume()
}
   
    
    // fetch rocket by id
    func fetchRocketByID(rocketID: String,completionHandler:@escaping (Rocket) -> Void) {
        
        //api parametes
        let fetchURl = "https://api.spacexdata.com/v4/rockets/\(rocketID)"
        let method: HTTPMethod = .get
        let headers: HTTPHeaders? = nil
        
        AF.request(fetchURl,method: method,encoding:JSONEncoding.default, headers: headers).responseJSON {
            (response) in
            
            // fetched data
            let fetchedJson = try! JSON(data: response.data!)
            
            //create instance of rocket
            var rocket = Rocket()
            
            //get rocket images
            var rocketImages = [URL]()
            for index in 0..<fetchedJson["flickr_images"].count{
                rocketImages.append(fetchedJson["flickr_images"][index].url!)
            }
            
            rocket.rocketID = fetchedJson["id"].string
            rocket.rocketName = fetchedJson["name"].string
            rocket.rocketDetails = fetchedJson["description"].string
            rocket.rocketWikipediaLink = fetchedJson["wikipedia"].url
            rocket.rocketImages = rocketImages
            
            //return rocket
            DispatchQueue.main.async {
                completionHandler(rocket)
            }
            
        }.resume()
}
    
}
