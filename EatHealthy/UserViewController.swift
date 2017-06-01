//
//  UserViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth

fileprivate let reuseIdentifier = "calorieGraph"

class UserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
               
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.backgroundColor = UIColor.darkGray
        
        setupCollectionViewCells()
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
        
        // Get user info
        if let user = Auth.auth().currentUser {
            if let displayName = user.displayName, let photoUrl = user.photoURL {
                nameLabel.text = displayName
                Alamofire.request(photoUrl).responseData { response in
                    if let data = response.result.value {
                        self.profileImage.image = UIImage(data: data)
                    }
                }
            } else {
                nameLabel.text = user.email
            }
            
            //Alamofire.request(user.photoURL!).responseData { response in
            //   if let data = response.result.value {
            //        self.profileImage.image = UIImage(data: data)
            //}
            //}
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let itemWidth = 375
        let itemHeight = 478
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalorieGraphCollectionViewCell
        
        let monts: [String]! = ["Jan","Feb","Mar","Apr"]
        let unitsSold = [20.0, 50.0, 6.0, 12.0]
        
        cell.setChart(dataPoints: monts, values: unitsSold)
        
        return cell
    }
}
