//
//  LogInViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/11/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import SwiftMessages

fileprivate let loginURL = "http://10.0.3.248/api/v1/clients/login"

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var logInUsernameTextField: UITextField!
    @IBOutlet weak var logInPasswordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        gradientBackground()//Gradient background
        
        /* Add the delegate to the TextField */
        logInUsernameTextField.delegate = self
        logInPasswordTextField.delegate = self
        
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
        let alertController = UIAlertController(title: "Forgot your username or password?", message: "Please enter your email to so we can send you a reset link.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addTextField { (textField: UITextField) -> Void in
            textField.placeholder = "Enter email"
        }
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) in
            let email = alertController.textFields?.first?.text
            Auth.auth().sendPasswordReset(withEmail: email!, completion: { (error) in
                if error != nil {
                    let view = MessageView.viewFromNib(layout: .StatusLine)
                    view.configureTheme(.error)
                    view.configureDropShadow()
                    view.configureContent(title: "Failed", body: "Invalid email address please try again.")
                    SwiftMessages.show(view: view)
                } else {
                    let view = MessageView.viewFromNib(layout: .StatusLine)
                    view.configureTheme(.success)
                    view.configureDropShadow()
                    view.configureContent(title: "Success", body: "We have sent you a verification email.")
                    SwiftMessages.show(view: view)
                }
            })
        }))
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
    
    
    // Facebook Log in
    @IBAction func facebookLogIn(_ sender: Any) {
        let fbLoginManager = FBSDKLoginManager()

        fbLoginManager.logOut()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                let view = MessageView.viewFromNib(layout: .StatusLine)
                view.configureTheme(.success)
                view.configureDropShadow()
                view.configureContent(title: "Success", body: "Successfully logged in.")
                SwiftMessages.show(view: view)
                // Present the main view
                if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") {
                    UIApplication.shared.keyWindow?.rootViewController = viewController
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    
    
    // Log in
    // ====================================================================================
    @IBAction func logInButtonClicked(_ sender: Any) {
        
        if logInUsernameTextField.text == "" || logInPasswordTextField.text == "" {
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            let view = MessageView.viewFromNib(layout: .StatusLine)
            view.configureTheme(.warning)
            view.configureDropShadow()
            view.configureContent(title: "Warning", body: "Please enter an email and password.")
            SwiftMessages.show(view: view)
        } else {
            Auth.auth().signIn(withEmail: logInUsernameTextField.text!, password: logInPasswordTextField.text!) { (user, error) in
                if error == nil {
                    // Show success login status
                    let view = MessageView.viewFromNib(layout: .StatusLine)
                    view.configureTheme(.success)
                    view.configureDropShadow()
                    view.configureContent(title: "Success", body: "Successfully logged in.")
                    SwiftMessages.show(view: view)
                    //Go to the HomeViewController if the login is sucessful
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.present(viewController, animated: true, completion: nil)
                } else {
                    let view = MessageView.viewFromNib(layout: .StatusLine)
                    view.configureTheme(.warning)
                    view.configureDropShadow()
                    view.configureContent(title: "Warning", body: (error?.localizedDescription)!)
                    SwiftMessages.show(view: view)
                }
            }
        }

        /* Using FIREBASE while API gets going
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
        }*/
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











