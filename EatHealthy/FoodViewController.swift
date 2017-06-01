//
//  FoodViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 1/29/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftMessages

fileprivate let reuseIdentifier = "foodItem"

// Search, get food and info
fileprivate let foodUrl = "https://nutritionix-api.p.mashape.com/v1_1/search/"
fileprivate let foodHeaders: HTTPHeaders = [
    "X-Mashape-Key": "f9tu0vzpSzmsh1sGYORDSymL5bnHp1yylpQjsnTql6OnZMnF9O",
    "Accept": "application/json"
]

class FoodViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var quantityStepper: UIStepper!
    
    var productsCount: Int = 0
    var cellId: Int = 0
    var itemsArray: Array<String> = []
    var itemsCalories: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self

        setupCollectionViewCells()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        updateCell(having: IndexPath(row: cellId, section: 0), selected: false)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
        updateCell(having: IndexPath(row: cellId, section: 0), selected: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.text = ""
        
        itemsArray.removeAll()
        itemsCalories.removeAll()
        let phrase = "apple"
        
        Alamofire.request("\(foodUrl)\(phrase)?fields=item_name%2Cnf_calories", method: .get, headers: foodHeaders).responseJSON { response in
            guard response.result.isSuccess else {
                print()
                return
            }
            let jsonData = JSON(response.result.value!)
            
            let jsonProducts = jsonData["hits"]
            let jsonProductsCount = jsonData["hits"].count
            self.productsCount = jsonProductsCount
            
            print(self.productsCount)
            
            //print(jsonProducts)
            
            for(key, value):(String, JSON) in jsonProducts {
                for (primaryKey, primaryValue):(String, JSON) in value {
                    for (secondaryKey, secondaryValue):(String, JSON) in primaryValue {
                        if(secondaryKey == "item_name") {
                            let productName = secondaryValue.string
                            self.itemsArray.append(productName!)
                        }else if(secondaryKey == "nf_calories") {
                            let productCalories = secondaryValue.int
                            self.itemsCalories.append(productCalories!)
                        }
                    }
                }
            }
            self.collectionView.reloadData()
        }
        
        updateCell(having: IndexPath(row: cellId, section: 0), selected: false)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        self.itemsArray.removeAll()
        self.itemsCalories.removeAll()
        let phrase = self.searchBar.text!
        
        
        Alamofire.request("\(foodUrl)\(phrase)?fields=item_name%2Cnf_calories", method: .get, headers: foodHeaders).responseJSON { response in
            guard response.result.isSuccess else {
                print()
                return
            }
            let jsonData = JSON(response.result.value!)
            
            let jsonProducts = jsonData["hits"]
            let jsonProductsCount = jsonData["hits"].count
            self.productsCount = jsonProductsCount
            
            //print(self.productsCount)
            //print(jsonProducts)
            
            for(key, value):(String, JSON) in jsonProducts {
                for (primaryKey, primaryValue):(String, JSON) in value {
                    for (secondaryKey, secondaryValue):(String, JSON) in primaryValue {
                        if(secondaryKey == "item_name") {
                            let productName = secondaryValue.string
                            self.itemsArray.append(productName!)
                        }else if(secondaryKey == "nf_calories") {
                            let productCalories = secondaryValue.int
                            self.itemsCalories.append(productCalories!)
                        }
                    }
                }
            }
            self.collectionView.reloadData()
        }
        
        updateCell(having: IndexPath(row: cellId, section: 0), selected: false)
    }
    
    func setupCollectionViewCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        let itemWidth = 375
        let itemHeight = 70
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FoodItemCell else { fatalError() }
        
        let itemName = itemsArray[indexPath.row]
        let itemCalories = String(itemsCalories[indexPath.row])
        
        cell.foodName.text = itemName
        cell.caloriesLabel.text = itemCalories
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateCell(having: indexPath, selected: true)
        
        quantityStepper.value = 100
        updateDisplayWith(cellIndex: indexPath.row, gramsValue: 100)
        cellId = indexPath.row
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
        if !selected {
            caloriesLabel.text = ""
            gramsLabel.text = ""
        }
    }
    
    // Change item quantity
    // ====================================================================================
    @IBAction func updateQuantity(_ sender: UIStepper) {
        let grams = Int(quantityStepper.value)
        
        updateDisplayWith(cellIndex: cellId, gramsValue: grams)
    }
    
    // Update text and number displays
    // ====================================================================================
    func updateDisplayWith(cellIndex: Int, gramsValue: Int) {
        let caloriesValue = Double(itemsCalories[cellIndex])/100 * Double(gramsValue)
        caloriesLabel.text = String(Int(caloriesValue))
        gramsLabel.text = String(describing: Int(gramsValue))
    }
    
    // Add foods to diary
    // ====================================================================================
    @IBAction func addToDiary(_ sender: Any) {
        let view = MessageView.viewFromNib(layout: .StatusLine)
        view.configureTheme(.success)
        view.configureDropShadow()
        view.configureContent(title: "Success", body: "Food has been added to your diary.")
        SwiftMessages.show(view: view)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
