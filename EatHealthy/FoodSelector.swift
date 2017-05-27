//
//  FoodSelector.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/29/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import Foundation
import UIKit

enum FoodSelection: String {
    
    // Random
    // ===============
    case soda
    case dietSoda
    case chips
    case cookie
    case candyBar
    case popTart
    case water
    case fruitJuice
    case sportsDrink
    case gum
    
    
    // Desserts
    // ===============
    case bananaSplit
    case cottonCandy
    case iceCreamCone
    case iceCreamBowl
    case nonyaKueh
    case chocolateBar
    case pastelDeNata
    
    // Dishes
    // ===============
    case cheese
    case sushi
    case spaghetti
    case noodles
    case bento
    case tinCan
    case dolmades
    case tapas
    case pancake
    case sauce
    case riceBowl
    case porridge
    case dimSum
    case sunnySideUpEggs
    case paella
    
    // Fast food
    // ===============
    case pizza
    case taco
    case hotDog
    case frenchFries
    case wrap
    case hamburger
    case nachos
    case quesadilla
    case sandwich
    
    // Fruits
    // ===============
    case citrus
    case pear
    case apple
    case avocado
    case watermelon
    case kiwi
    case pomegranate
    case pineapple
    case dragonFruit
    case peach
    case banana
    case melon
    case plum
    case durian
    
    func icon() -> UIImage {
        if let image = UIImage(named: self.rawValue) {
            return image
        } else {
            return #imageLiteral(resourceName: "default")
        }
    }
    
    func itemName() -> String {
        let itemName = self.rawValue
        return itemName
    }
}

protocol FoodItem {
    var calories: Int {get set}
}

protocol FoodSelector {
    var selection: [FoodSelection] {get}
    var inventory: [FoodSelection: FoodItem] {get set}
    
    init(inventory: [FoodSelection: FoodItem])
    
    func getItem(_ selection: FoodSelection,_ calories: Int) throws
}

struct Item: FoodItem {
    
    var calories: Int
}

enum InventoryError: Error {
    case invalidResource
    case conversionFailure
    case invalidSelection
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw InventoryError.invalidResource
        }
        
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            throw InventoryError.conversionFailure
        }
        
        return dictionary
    }
}

class InventoryUnarchiver {
    static func userInventory(fromDictionary dictionary: [String: AnyObject]) throws -> [FoodSelection: FoodItem] {
    
        var inventory: [FoodSelection: FoodItem] = [:]
        
        for (key, value) in dictionary {
            if let itemDictionary = value as? [String: Any], let calories = itemDictionary["calories"] as? Int {
                let item = Item(calories: calories)
                
                guard let selection = FoodSelection(rawValue: key) else {
                    throw InventoryError.invalidSelection
                }
                
                inventory.updateValue(item, forKey: selection)
            }
        }
        
        return inventory
    }
}

class FoodSelected: FoodSelector {
    let selection: [FoodSelection] = [.apple, .avocado, .banana, .bananaSplit, .bento, .candyBar, .cheese, .chips]
    var inventory: [FoodSelection : FoodItem]
    
    required init(inventory: [FoodSelection: FoodItem]) {
        self.inventory = inventory
    }
    
    func getItem(_ selection: FoodSelection,_ calories: Int) {
    }
}






