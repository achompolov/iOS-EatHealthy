//
//  SignUpViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let registerURL = "http://93.152.131.62/api/v1/clients/register"
    
    @IBOutlet weak var signUpNameTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpUsernameTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    @IBOutlet weak var signUpConfirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBirthDate: UITextField!
    @IBOutlet weak var signUpGender: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    // signUpBirthDate: UITextField to UIDatePicker on editing
    // ====================================================================================
    let datePickerView: UIDatePicker = UIDatePicker()
    func toBirthDatePicker() {
            let toolbar = UIToolbar()
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolbarBirthDateDonePressed))
            toolbar.sizeToFit()
            toolbar.setItems([doneButton], animated: true)
        
            signUpBirthDate.inputAccessoryView = toolbar
            datePickerView.datePickerMode = UIDatePickerMode.date
            signUpBirthDate.inputView = datePickerView
    }
    func toolbarBirthDateDonePressed() {
        //Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        
        //Assign the date to the UITextField
        signUpBirthDate.text = dateFormatter.string(from: datePickerView.date)
        if (signUpGender.text?.isEmpty)! {
            signUpGender.becomeFirstResponder()
        } else {
            signUpBirthDate.resignFirstResponder()
        }
    }
    
    // signUpGender: UITextField to UIPickerView on editing
    // ====================================================================================
    let genders = ["Male", "Female"]
    func toGenderPicker() {
        let genderPickerView: UIPickerView = UIPickerView()
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolBarGenderDonePressed))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        signUpGender.inputAccessoryView = toolbar
        genderPickerView.delegate = self
        signUpGender.inputView = genderPickerView
    }
    func toolBarGenderDonePressed() {
        signUpGender.resignFirstResponder()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        signUpGender.text = genders[row]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        gradientBackground() //Gradient background
        
        // Add the delegate to the TextField
        self.signUpNameTextField.delegate = self
        self.signUpEmailTextField.delegate = self
        self.signUpUsernameTextField.delegate = self
        self.signUpPasswordTextField.delegate = self
        self.signUpConfirmPasswordTextField.delegate = self
        self.signUpBirthDate.delegate = self
        self.signUpGender.delegate = self
        
        toBirthDatePicker() //DatePickerView from signUpBirthDate
        toGenderPicker() //PickerView from signUpGender
        addClearButtonToTextFields() //Clear button to UITextFields
        
        signUpButton.isEnabled = false
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
        self.navigationItem.title = "Sign up"
    }
    
    // Hide keyboard when user touches outside keyboard
    // ====================================================================================
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    // Clear button to UITextFields
    // ====================================================================================
    func addClearButtonToTextFields() {
        signUpNameTextField.clearButtonMode = .whileEditing
        signUpEmailTextField.clearButtonMode = .whileEditing
        signUpUsernameTextField.clearButtonMode = .whileEditing
        signUpPasswordTextField.clearButtonMode = .whileEditing
        signUpConfirmPasswordTextField.clearButtonMode = .whileEditing
    }
    
    // Form validation and signUpButton enable
    // ====================================================================================
    func validateSignUpForm() -> Bool {
        if( ((signUpEmailTextField.text?.isEmpty)!) ||
            ((signUpNameTextField.text?.isEmpty)!) ||
            ((signUpUsernameTextField.text?.isEmpty)!) ||
            ((signUpPasswordTextField.text?.isEmpty)!) ||
            ((signUpConfirmPasswordTextField.text?.isEmpty)!) ||
            ((signUpBirthDate.text?.isEmpty)!) ||
            ((signUpGender.text?.isEmpty)!)) {
            return false
        }else {
            return true
        }
    }
    
    func isEmailValid(email: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z{2,}]"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: email)
    }
    
    
    // Send the sign up form to the server
    // ====================================================================================
    @IBAction func signUpButtonClicked(_ sender: Any) {

        if signUpEmailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: signUpEmailTextField.text!, password: signUpPasswordTextField.text!) { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.present(viewcontroller, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }



        /* Using FIREBASE while API gets going
        if !isEmailValid(email: signUpEmailTextField.text!) {
            signUpEmailTextField.backgroundColor = UIColor.red
            let alertController = UIAlertController(title: "Invalid email address", message: "Please check your email.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else if signUpEmailTextField.backgroundColor == UIColor.red {
            signUpEmailTextField.backgroundColor = UIColor.white
        }else if signUpPasswordTextField.backgroundColor == UIColor.red {
            signUpPasswordTextField.backgroundColor = UIColor.white
            signUpConfirmPasswordTextField.backgroundColor = UIColor.white
        } else if signUpPasswordTextField.text != signUpConfirmPasswordTextField.text {
            signUpPasswordTextField.backgroundColor = UIColor.red
            signUpConfirmPasswordTextField.backgroundColor = UIColor.red
            let alertController = UIAlertController(title: "Passwords does not match", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        } else {
            let parameters: Parameters = [
                "email": signUpEmailTextField.text!,
                "password": signUpPasswordTextField.text!,
                "password_confirmation": signUpConfirmPasswordTextField.text!
            ]
            
            Alamofire.request(registerURL, method: .post, parameters: parameters).responseJSON {
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
                        let alertController = UIAlertController(title: "Unable to sign up", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        }*/
    }
    
    // Change to LogInViewController
    // ====================================================================================
    @IBAction func alreadyHaveAnAccount(_ sender: Any) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "logIn") as! LogInViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // Check if the sign up for is valid and enable sign up button
    // ====================================================================================
    @IBAction func formDidEndEditing(_ sender: UITextField) {
        if validateSignUpForm() {
            signUpButton.tintColor = UIColor(red: 167/255.0, green: 169/255.0, blue: 172/255.0, alpha: 1.0)
            signUpButton.backgroundColor = UIColor.white
            signUpButton.isEnabled = true
        }
    }
}

