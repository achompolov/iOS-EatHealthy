//
//  SettingsViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftMessages

class SettingsViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButtonClicked(_ sender: Any) {
        let logOutAlert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        logOutAlert.addAction(UIAlertAction(title: "Yes, I'm sure.", style: .default, handler: { (action: UIAlertAction!) in
            if Auth.auth().currentUser != nil {
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
        }))
        logOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(logOutAlert, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
