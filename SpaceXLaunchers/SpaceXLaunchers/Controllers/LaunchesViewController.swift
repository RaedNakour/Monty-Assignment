//
//  LaunchesViewController.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import UIKit

class LaunchesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NetworkCalls {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var goldButtonLabel: UILabel!
    
    private let launchCellIdentifier = "LaunchCell"
    private let rocketStoryBoardIdentifier = "RocketView"
    
    
    var fetchedLaunches = [LaunchViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting gold button attributes
        goldButtonLabel.layer.masksToBounds = true
        goldButtonLabel.layer.cornerRadius = 15
        
        //fetch launches from api
        self.fetchLaunchesByDate(completionHandler: { (response) in
            self.fetchedLaunches = response.map({return LaunchViewModel(launch: $0)})
            self.collectionView.reloadData()
            self.setupCollectionViewLayout()
        })

        
    }
    
    //set collection view layout
    func setupCollectionViewLayout() {
        let newLayout = CustomCollectionViewLayout()
        newLayout.spacingLeft = 0
        newLayout.scrollDirection = .horizontal
        newLayout.itemSize = CGSize(width: 190, height: 200)
        collectionView.collectionViewLayout = newLayout
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    // get collection view rows
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedLaunches.count
    }
    
    
    // fill collection view with images
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.launchCellIdentifier, for: indexPath) as? LaunchCollectionViewCell

        let launchViewModel = fetchedLaunches[indexPath.row]
        cell?.launchViewModel = launchViewModel
            
        return cell!
    }
    
    
    //adjust collection view size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 200)
    }
    
    
    //on cell tapped
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get rocket by id
        let rocketID = fetchedLaunches[indexPath.row].launchRocketID
        self.fetchRocketByID(rocketID: rocketID, completionHandler: { (fetchedRocket) in
            //navigate to rocket view
            if let rocketController = self.storyboard?.instantiateViewController(withIdentifier: self.rocketStoryBoardIdentifier) as? RocketViewController {
                // set selected rocket and launch date value
                rocketController.selectedRocket = RocketViewModel(rocket: fetchedRocket)
                rocketController.selectedLaunchDate = self.fetchedLaunches[indexPath.row].launchDate
                //navigate
                self.navigationController?.pushViewController(rocketController, animated: true)
            }
        })
    }

}
