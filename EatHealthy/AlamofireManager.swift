//
//  AlamofireManager.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/26/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireManager: NSObject {
    override init() {
        super.init()
    }
    
    static let sharedInstance = AlamofireManager()
    
    // API Routes
    // ====================================================================================
    let apiURL: String = "http://localhost:8080/api" //Main api url
    
}
