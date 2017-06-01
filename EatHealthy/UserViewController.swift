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
    
    var days: [String]! = []
    var weeks: [String]! = []
    var months: [String]! = []
    var caloriesByDay: [Double] = []
    var caloriesByWeek: [Double] = []
    var caloriesByMonth: [Double] = []
    
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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CalorieGraphCollectionViewCell
        
        switch indexPath.row {
        case 0:
            days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
            caloriesByDay = [1252.0, 985.0, 2450.0, 1604.0, 734.0, 1325.0, 2623.0]
            
            cell.setChart(dataPoints: days, values: caloriesByDay)
        case 1:
            weeks = ["First", "Seconds", "Third", "Fourth"]
            caloriesByWeek = [14245.0, 9341.0, 2343.0, 5431.0]
            cell.setChart(dataPoints: weeks, values: caloriesByWeek)
        case 2:
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            caloriesByMonth = [40321.0, 54738.0, 75938.0, 19583.0, 57302.0, 47917.0, 37194.0, 96843.0, 57391.0, 85729.0, 16382.0, 37194.0]
            cell.setChart(dataPoints: months, values: caloriesByMonth)
        default:
            cell.setChart(dataPoints: [], values: [])
        }
        
        return cell
    }
}
