//
//  FoodViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/29/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "foodItem"
fileprivate let screenWidth = UIScreen.main.bounds.width

class FoodViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    let foodSelector: FoodSelector
    
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionary = try PlistConverter.dictionary(fromFile: "FoodList", ofType: "plist")
            let inventory = try InventoryUnarchiver.userInventory(fromDictionary: dictionary)
            self.foodSelector = FoodSelected(inventory: inventory)
        } catch let error {
            fatalError("\(error)")
        }
        
        super.init(coder: aDecoder)
    }
    
    
    
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
        
        let padding: CGFloat = 10
        let itemWidth = screenWidth/4 - padding
        let itemHeight = itemWidth
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
    }	
    
    
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodSelector.selection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FoodItemCell else { fatalError() }
        
        let item = foodSelector.selection[indexPath.row]
        cell.iconView.image = item.icon()
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: true)
        
        quantityStepper.value = 1

        let food = foodSelector.selection[indexPath.row]
        //let foodName = food.itemName()
        
        updateDisplayWith(itemName: food.itemName(), itemQuantity: 1)
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
            itemNameLabel.text = "\(foodName)"
            
            switch foodName {
            case "apple":
                kcalLabel.text = "200"
                gramsLabel.text = "(23 g)"
            case "avocado":
                kcalLabel.text = "100"
                gramsLabel.text = "(30 g)"
            case "banana":
                kcalLabel.text = "150"
                gramsLabel.text = "(25 g)"
            case "bananaSplit":
                kcalLabel.text = "50"
                gramsLabel.text = "(151 g)"
            case "bento":
                kcalLabel.text = "10"
                gramsLabel.text = "(45 g)"
            case "candyBar":
                kcalLabel.text = "20"
                gramsLabel.text = "(29 g)"
            case "cheese":
                kcalLabel.text = "300"
                gramsLabel.text = "(76 g)"
            case "chips":
                kcalLabel.text = "30"
                gramsLabel.text = "(15 g)"
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
