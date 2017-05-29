//
//  SettingsViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit

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
        // Present Logged out Alert
        let logOutAlert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        logOutAlert.addAction(UIAlertAction(title: "Yes, I'm sure.", style: .default, handler: { (action: UIAlertAction!) in
            // Present HomeViewController
            // ================================================================
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "navController") as! UINavigationController
            self.present(viewController, animated: true, completion: nil)
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
