//
//  StormpathManager.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 5/14/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Stormpath

class StormpathManager: NSObject {
    override init() {
        super.init()
    }
    
    static let sharedInstance = StormpathManager()
    
    func userRegistration(name: String, email: String, username: String, password: String, birthDate: Date, gender: String) {
        Stormpath.sharedSession.configuration.APIURL = URL(string: "")!
        let newUser = RegistrationForm(email: email, password: password)
        
        Stormpath.sharedSession.register(account: newUser) { (account, error) -> Void in
            guard let account = account, error == nil else {
                //The account registration failed
                return
            }
            // Do something with the returned account object, such as save its `href` if needed.
            // Registering a user will not automatically log them in.
            print("registered")
        }
    }
    
    func userLogin(username: String, password: String) {
        Stormpath.sharedSession.login(username: username, password: password) { success, error in
            guard error == nil else {
                //We could not authenticate the user with the given credentials. Handle the error.
                return
            }
            //The user is now logged in, and you can use the Stormpath acces token to make API request!
            print("logged in")
        }
    
    }
    

}
