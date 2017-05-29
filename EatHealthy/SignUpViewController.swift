//
//  SignUpViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let registerURL = "http://93.152.131.62/api/v1/clients/register"
    
    @IBOutlet weak var signUpNameTextField: UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpUsernameTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
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
        } else if (isValidEmail(testStr: signUpEmailTextField.text!) && validateSignUpForm()) {
            signUpBirthDate.resignFirstResponder()
        } else {
            signUpBirthDate.resignFirstResponder()
        }
    }
    
    // signUpGender: UITextField to UIPickerView on editing
    // ====================================================================================
    let genders = ["Female", "Male", "Other"]
    func toGenderPicker() {
        let genderPickerView: UIPickerView = UIPickerView()
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(toolbarGenderDonePressed))
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        signUpGender.inputAccessoryView = toolbar
        genderPickerView.delegate = self
        signUpGender.inputView = genderPickerView
    }
    func toolbarGenderDonePressed() {
        if (isValidEmail(testStr: signUpEmailTextField.text!) && validateSignUpForm()) {
            signUpGender.resignFirstResponder()
        } else {
            signUpGender.resignFirstResponder()
        }
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
    
    // Hide keyboard when user touches "return"
    // ====================================================================================
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case signUpNameTextField:
            if !((signUpEmailTextField.text?.isEmpty)!){
                signUpNameTextField.resignFirstResponder()
            } else if (signUpEmailTextField.text?.isEmpty)!  {
                signUpEmailTextField.becomeFirstResponder()
            }
        case signUpEmailTextField:
            if !((signUpUsernameTextField.text?.isEmpty)!) && !((signUpNameTextField.text?.isEmpty)!) {
                signUpEmailTextField.resignFirstResponder()
            } else if (signUpUsernameTextField.text?.isEmpty)! && (signUpNameTextField.text?.isEmpty)! {
                signUpUsernameTextField.becomeFirstResponder()
            } else if !((signUpUsernameTextField.text?.isEmpty)!) && (signUpNameTextField.text?.isEmpty)!  {
                signUpNameTextField.becomeFirstResponder()
            } else if ((signUpUsernameTextField.text?.isEmpty)!) && !((signUpNameTextField.text?.isEmpty)!){
                signUpUsernameTextField.becomeFirstResponder()
            }
        case signUpUsernameTextField:
            if !((signUpPasswordTextField.text?.isEmpty)!) && !((signUpEmailTextField.text?.isEmpty)!) {
                signUpUsernameTextField.resignFirstResponder()
            } else if (signUpPasswordTextField.text?.isEmpty)! && (signUpEmailTextField.text?.isEmpty)! {
                signUpPasswordTextField.becomeFirstResponder()
            } else if !((signUpPasswordTextField.text?.isEmpty)!) && (signUpEmailTextField.text?.isEmpty)!  {
                signUpEmailTextField.becomeFirstResponder()
            } else if ((signUpPasswordTextField.text?.isEmpty)!) && !((signUpEmailTextField.text?.isEmpty)!){
                signUpPasswordTextField.becomeFirstResponder()
            }
        case signUpPasswordTextField:
            if !((signUpBirthDate.text?.isEmpty)!) && !((signUpUsernameTextField.text?.isEmpty)!) {
                signUpPasswordTextField.resignFirstResponder()
            } else if (signUpBirthDate.text?.isEmpty)! && (signUpUsernameTextField.text?.isEmpty)! {
                signUpBirthDate.becomeFirstResponder()
            } else if !((signUpBirthDate.text?.isEmpty)!) && (signUpUsernameTextField.text?.isEmpty)!  {
                signUpUsernameTextField.becomeFirstResponder()
            } else if ((signUpBirthDate.text?.isEmpty)!) && !((signUpUsernameTextField.text?.isEmpty)!){
                signUpBirthDate.becomeFirstResponder()
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
    
    // Clear button to UITextFields
    // ====================================================================================
    func addClearButtonToTextFields() {
        signUpNameTextField.clearButtonMode = .whileEditing
        signUpEmailTextField.clearButtonMode = .whileEditing
        signUpUsernameTextField.clearButtonMode = .whileEditing
        signUpPasswordTextField.clearButtonMode = .whileEditing
    }
    
    // E-mail validation
    // ====================================================================================
    func isValidEmail(testStr: String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    @IBAction func validateEmail(_ sender: UITextField) {
        if ((!(isValidEmail(testStr: signUpEmailTextField.text!)) && ((signUpEmailTextField.text?.isEmpty)! == false))) {
            signUpEmailTextField.backgroundColor = UIColor.red
        } else {
            signUpEmailTextField.backgroundColor = UIColor.white
        }
    }
    
    
    // Form validation and signUpButton enable
    // ====================================================================================
    func validateSignUpForm() -> Bool {
        if(((signUpEmailTextField.text?.isEmpty)!) || ((signUpNameTextField.text?.isEmpty)!) || ((signUpUsernameTextField.text?.isEmpty)!) || ((signUpPasswordTextField.text?.isEmpty)!) || ((signUpBirthDate.text?.isEmpty)!) || ((signUpGender.text?.isEmpty)!)) {
            return false
        }else {
            return true
        }
    }
    
    
    // Send the sign up form to the server
    // ====================================================================================
    @IBAction func signUpButtonClicked(_ sender: Any) {
       
        let parameters: Parameters = [
            "email": signUpEmailTextField.text!,
            "password": signUpPasswordTextField.text!
        ]
        
        Alamofire.request(registerURL, method: .post, parameters: parameters).responseJSON {
            response in
            print(response)
            
            if let result = response.result.value {
                let jsonData = result as! NSDictionary
                
                let apiStatusCode = jsonData.value(forKey: "api_status_code") as! Int
                
                if apiStatusCode == 200 {
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
        if (isValidEmail(testStr: signUpEmailTextField.text!) && validateSignUpForm()) {
            signUpButton.tintColor = UIColor(red: 167/255.0, green: 169/255.0, blue: 172/255.0, alpha: 1.0)
            signUpButton.backgroundColor = UIColor.white
            signUpButton.isEnabled = true
        }
    }
}

