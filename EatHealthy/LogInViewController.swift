//
//  LogInViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/11/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    let loginURL = "http://10.0.3.248/api/v1/clients/login"
    
    
    @IBOutlet weak var logInUsernameTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gradientBackground()//Gradient background
        
        /* Add the delegate to the TextField */
        self.logInUsernameTextField.delegate = self
        self.logInPasswordTextField.delegate = self
        
        addClearButtonToTextField() //Clear buttons
        
        logInButton.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Show, change color, add title to navigation bar
        // ================================================================
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationItem.title = "Log in"
    }
    
    
    // Hide keyboard when user touches outside keyboard or "return"
    // ====================================================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case logInUsernameTextField:
            if (logInPasswordTextField.text?.isEmpty)! {
                logInPasswordTextField.becomeFirstResponder()
            } else {
                logInUsernameTextField.resignFirstResponder()
            }
        case logInPasswordTextField:
            if (logInUsernameTextField.text?.isEmpty)! {
                logInUsernameTextField.becomeFirstResponder()
            } else {
                logInPasswordTextField.resignFirstResponder()
            }
        default:
            textField.resignFirstResponder()
        }
        
        
        
        return true
    }
    
    // Adding gradient background
    // ====================================================================================
    func gradientBackground() {
        let gradientBackground = CAGradientLayer()
        gradientBackground.frame = view.bounds
        gradientBackground.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientBackground.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientBackground.colors = [
            UIColor(red: 38/225.0, green: 218/225.0, blue: 200/225.0, alpha: 1.0).cgColor,
            UIColor(red: 38/225.0, green: 140/225.0, blue: 218/225.0, alpha: 1.0).cgColor
        ]
        view.layer.insertSublayer(gradientBackground, at: 0) //Adding the background layer at z-index 0
    }

    // Forgot your username or password alert
    // ====================================================================================
    @IBAction func forgotUsernameOrPasswordAlert() {
        let alertController = UIAlertController(title: "Forgot your username or password?", message: "This function will be added in later state of the application.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // Clear button to textfields
    // ====================================================================================
    func addClearButtonToTextField() {
        logInUsernameTextField.clearButtonMode = .whileEditing
        logInPasswordTextField.clearButtonMode = .whileEditing
    }
    
    // Form validation and signUpButton enable
    // ====================================================================================
    func validateLogInForm() -> Bool {
        if(((logInUsernameTextField.text?.isEmpty)!) || ((logInPasswordTextField.text?.isEmpty)!)) {
            return false
        }else {
            return true
        }
    }
    
    // Send the log in form to the server
    // ====================================================================================
    @IBAction func logInButtonClicked(_ sender: Any) {
        // Present FoodViewController
        // ================================================================
        let viewController = storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
        present(viewController, animated: true, completion: nil)
        
        let parameters: Parameters = [
            "email": logInUsernameTextField.text!,
            "password": logInPasswordTextField.text!
        ]
        
        Alamofire.request(loginURL, method: .post, parameters: parameters).responseJSON {
            response in
                print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                
                let apiStatusCode = jsonData.value(forKey: "api_status_code") as! Int
                let token = jsonData.value(forKey: "data") as! String
                
                if apiStatusCode == 200 {
                    UserDefaults.standard.set(token, forKey: "token")
                    
                    // Present FoodViewController
                    // ================================================================
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.present(viewController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Unable to log in", message: "Wrong username or password.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // Change to SignUpViewController
    // ====================================================================================
    @IBAction func dontHaveAnAccount(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Check if the log in is valid and enable log up button
    // ====================================================================================
    @IBAction func logInFormDidEndEditing(_ sender: UITextField) {
        if (validateLogInForm()) {
            logInButton.tintColor = UIColor(red: 167/255.0, green: 169/255.0, blue: 172/255.0, alpha: 1.0)
            logInButton.backgroundColor = UIColor.white
            logInButton.isEnabled = true
        }
    }
    
    
}











