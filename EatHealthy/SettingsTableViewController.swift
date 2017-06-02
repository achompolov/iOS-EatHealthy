//
//  SettingsTableViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 6/1/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftMessages

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOut(_ sender: Any) {
        let logOutAlert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        logOutAlert.addAction(UIAlertAction(title: "Yes, I'm sure.", style: .default, handler: { (action: UIAlertAction!) in
                do {
                    try Auth.auth().signOut()
                    let view = MessageView.viewFromNib(layout: .StatusLine)
                    view.configureTheme(.success)
                    view.configureDropShadow()
                    view.configureContent(title: "Success", body: "Successfully logged out.")
                    SwiftMessages.show(view: view)
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "navController") as! UINavigationController
                    self.present(viewController, animated: true, completion: nil)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        ))
        logOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(logOutAlert, animated: true, completion: nil)
    }

}
