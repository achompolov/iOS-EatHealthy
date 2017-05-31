//
//  FoodGetter.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 5/31/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

class FoodManager: NSObject {
    override init() {
        super.init()
    }
    
    static let sharedInstance = FoodManager()
    
    // CHECK IF FOODAPI IS WORKING
    let headers: HTTPHeaders = [
        "X-Mashape-Key": "f9tu0vzpSzmsh1sGYORDSymL5bnHp1yylpQjsnTql6OnZMnF9O",
        "Accept": "application/json"
    ]
    
    
    let parameters: Parameters = [
        "number": 1,
        "query": "s"
    ]
    
    let foodUrl = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/search"
    
    Alamofire.request(foodUrl, method: .get, parameters: parameters, headers: headers).responseJSON { response in
        print(response)
    }
}
