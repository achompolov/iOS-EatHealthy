//
//  AlamofireManager.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/12/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireManager: NSObject {
    // Private initializer for singleton
    fileprivate override init() {}
    static let sharedInstance = AlamofireManager()
    
    // Store access token in user defaults
    var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: )
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: Settings.AccessTokenKey)
        }
    }
    
    var currentUser: User!
    var isLoggedIn: Bool {
        return accessToken != nil
    }
    
    func login(username: String, password: String, success: ((Void) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        Alamofire.request(AuthenticationRouter.login(username, password)).responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                accessToken = json["jwt"].stringValue
                currentUser = User(json: json["user"])
                NotificationCenter.default.post(name: .userLoggedIn, object: nil)
                
                success?()
            case .failure(let error):
                failure?(error)
            }
        }
    }
    
    func logout() {
        accessToken = nil
        currentUser = nil
        NotificationCenter.default.post(name: .userLoggedOut, object: nil)
    }
    
    func refreshCurrentUser() {
        // Network here call to sync local data with server data
    }
}
