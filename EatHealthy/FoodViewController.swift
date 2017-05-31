//
//  FoodViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/29/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire

fileprivate let reuseIdentifier = "foodItem"

class FoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupCollectionViewCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let itemWidth = 375
        let itemHeight = 70
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }	
    
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FoodManager.sharedInstance.foodCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FoodItemCell else { fatalError() }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: true)
        
        quantityStepper.value = 1
        
        updateDisplayWith(itemQuantity: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: false)
    }
    
    
    // Update cell
    // ====================================================================================
    func updateCell(having indexPath: IndexPath, selected: Bool) {
        let selectedBackgroundColor = UIColor(red: 41/255.0, green: 211/255.0, blue: 241/255.0, alpha: 1.0)
        let defaultBackgroundColor = UIColor(red: 27/255.0, green: 32/255.0, blue: 36/255.0, alpha: 1.0)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = selected ? selectedBackgroundColor : defaultBackgroundColor
        }
    }
    
    // Change item quantity
    // ====================================================================================
    @IBAction func updateQuantity(_ sender: UIStepper) {
        let quantity = Int(quantityStepper.value)
        updateDisplayWith(itemQuantity: quantity)
    }
    
    // Update text and number displays
    // ====================================================================================
    func updateDisplayWith(itemName: String? = nil, itemQuantity: Int? = nil) {
        
        if let foodName = itemName {
            switch foodName {
            case "candyBar":
                itemNameLabel.text = "Candy Bar"
                kcalLabel.text = "200"
                gramsLabel.text = "(23 g)"
            case "chips":
                itemNameLabel.text = "Chips"
                kcalLabel.text = "199"
                gramsLabel.text = "(22 g)"
            case "cookie":
                itemNameLabel.text = "Cookie"
                kcalLabel.text = "189"
                gramsLabel.text = "(34 g)"
            case "dietSoda":
                itemNameLabel.text = "Diet Soda"
                kcalLabel.text = "900"
                gramsLabel.text = "(500 g)"
            case "fruitJuice":
                itemNameLabel.text = "Fruit Juice"
                kcalLabel.text = "211"
                gramsLabel.text = "(500 g)"
            case "popTart":
                itemNameLabel.text = "Pop Tart"
                kcalLabel.text = "300"
                gramsLabel.text = "(100 g)"
            case "sandwich":
                itemNameLabel.text = "Sandwich"
                kcalLabel.text = "200"
                gramsLabel.text = "(23 g)"
            case "soda":
                itemNameLabel.text = "Soda"
                kcalLabel.text = "800"
                gramsLabel.text = "(180 g)"
            case "sportsDrink":
                itemNameLabel.text = "Sports Drink"
                kcalLabel.text = "50"
                gramsLabel.text = "(500 g)"
            case "water":
                itemNameLabel.text = "Water"
                kcalLabel.text = "200"
                gramsLabel.text = "(500 g)"
            case "wrap":
                itemNameLabel.text = "Wrap"
                kcalLabel.text = "199"
                gramsLabel.text = "(183 g)"
            default:
                kcalLabel.text = "0"
                gramsLabel.text = "(0 g)"
            }
        }
        

        if let quantityValue = itemQuantity {
            quantityLabel.text = "\(quantityValue)"
        }
        
    }
}
