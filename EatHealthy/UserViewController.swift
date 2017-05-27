//
//  UserViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
               
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
