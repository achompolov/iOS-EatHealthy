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
import SwiftMessages

fileprivate let reuseIdentifier = "calorieGraph"

class UserViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var days: [String]! = []
    var months: [String]! = []
    var years: [String]! = []
    var caloriesByDay: [Double] = []
    var caloriesByMonth: [Double] = []
    var caloriesByYear: [Double] = []
    
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
    
    
    @IBAction func calorieCalc(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "Calculate how many calories you burn", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Age(Years)"
        }
        alertController.addTextField{ (textField: UITextField) -> Void in
            textField.placeholder = "Gender(Male/Female)"
        }
        alertController.addTextField{ (textField: UITextField) -> Void in
            textField.placeholder = "Height(Meters.Centimeters)"
        }
        alertController.addTextField{ (textField: UITextField) -> Void in
            textField.placeholder = "Weight(Kilograms)"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            let age = Double((alertController.textFields?[0].text)!)
            let gender = alertController.textFields?[1].text
            let height = Double((alertController.textFields?[2].text)!)
            let weight = Double((alertController.textFields?[3].text)!)
            var bmr: Double = 0
            
            if (gender == "Male" || gender == "male") {
                let bmrWeight = 13.75*weight!
                let bmrHeight = 5.0*height!
                let bmrAge = 6.75*age!
                
                bmr = 66.47+bmrWeight+bmrHeight-bmrAge

                self.showMessageView(bmr: bmr)
            }else if (gender == "Female" || gender == "female") {
                let bmrWeight = 9.56*weight!
                let bmrHeight = 1.84*height!
                let bmrAge = 4.67*age!
                
                bmr = 665.09+bmrWeight+bmrHeight-bmrAge
                self.showMessageView(bmr: bmr)
            }else {
                let view = MessageView.viewFromNib(layout: .StatusLine)
                view.configureTheme(.error)
                view.configureDropShadow()
                view.configureContent(title: "BMR Fail", body: "There was an error try again.")
                var viewConfig  = SwiftMessages.defaultConfig
                viewConfig.duration = .seconds(seconds: 1)
                SwiftMessages.show(config: viewConfig, view: view)
            }
        }))
        present(alertController, animated: true, completion: nil)
        
    }
 
    func showMessageView(bmr: Double) {
        let iconText = "😎"
        let view = MessageView.viewFromNib(layout: .CardView)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.button?.isHidden = true
        view.configureContent(title: "BMR", body: "You burn \(bmr)/daily", iconText: iconText)
        var viewConfig  = SwiftMessages.defaultConfig
        viewConfig.presentationStyle = .bottom
        viewConfig.duration = .seconds(seconds: 5)
        SwiftMessages.show(config: viewConfig, view: view)
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
            months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
            caloriesByMonth = [40321.0, 54738.0, 75938.0, 19583.0, 57302.0, 47917.0, 37194.0, 96843.0, 57391.0, 85729.0, 16382.0, 37194.0]
            cell.setChart(dataPoints: months, values: caloriesByMonth)
        case 2:
            years = ["2013", "2014", "2015", "2016", "2017"]
            caloriesByYear = [434243.0, 543533.0, 134423.0, 947284.0, 100493.0]
            cell.setChart(dataPoints: years, values: caloriesByYear)
        default:
            cell.setChart(dataPoints: [], values: [])
        }
        
        return cell
    }
}
