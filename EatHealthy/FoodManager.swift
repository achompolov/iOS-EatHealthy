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
    
    
    // Search and get food
    var foodCount: Int = 0
    
    let foodHeaders: HTTPHeaders = [
        "X-Mashape-Key": "f9tu0vzpSzmsh1sGYORDSymL5bnHp1yylpQjsnTql6OnZMnF9O",
        "Accept": "application/json"
    ]
    
    let foodParameters: Parameters = [
        "number": 1,
        "query": "s"
    ]
    
    let foodUrl = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/food/products/search"
    
    func getFoods(foodUrl: String, parameters: Parameters, headers: HTTPHeaders) {
        Alamofire.request(foodUrl, method: .get, parameters: parameters, headers: headers).responseJSON { response in
            
            let jsonData = JSON(response.result.value!)
            //print(jsonData)
            
            let jsonProductsCount = jsonData["products"].count
            self.foodCount = jsonProductsCount
        }
    }
    
}
