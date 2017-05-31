//
//  FoodGetter.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 5/31/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FoodManager: NSObject {
    override init() {
        super.init()
    }
    
    static let sharedInstance = FoodManager()
    
    
    func getFoods(foodUrl: String, parameters: Parameters, headers: HTTPHeaders) {
        Alamofire.request(foodUrl, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            
            guard response.result.isSuccess else {
                print()
                return
            }
            
            let jsonData = JSON(response.result.value!)
            //print(jsonData)
            
            let jsonProductsCount = jsonData["products"].count
            
        }
    }
    
}


