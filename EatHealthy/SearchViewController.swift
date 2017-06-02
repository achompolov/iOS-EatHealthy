//
//  SearchViewController.swift
//  EatHealthy
//
//  Created by Atanas Chompolov on 6/1/17.
//  Copyright © 2017 Atanas Chompolov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

fileprivate let reuseIdentifier = "recipeItem"
fileprivate let randomRecipeUrl = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/156992/similar"
fileprivate let searchRecipeUrl = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search"
fileprivate let recipeHeaders: HTTPHeaders = [
    "X-Mashape-Key": "f9tu0vzpSzmsh1sGYORDSymL5bnHp1yylpQjsnTql6OnZMnF9O",
    "Accept": "application/json"
]

class SearchViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    var productsCount: Int = 0
    var itemsArray: [String] = []
    var itemsPreparation: [Int] = []
    
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
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.text = ""
        itemsArray.removeAll()
    
        Alamofire.request("\(randomRecipeUrl)", method: .get,headers: recipeHeaders).responseJSON { response in
    
            guard response.result.isSuccess else {
                print()
                return
            }
    
            let jsonData = JSON(response.result.value!)
    
            let jsonProducts = jsonData
            let jsonProductsCount = jsonData.count
            self.productsCount = jsonProductsCount
    
            for(key, value):(String, JSON) in jsonProducts {
                for (primaryKey, primaryValue):(String, JSON) in value {
                    if(primaryKey == "title") {
                        let productName = primaryValue.string
                        self.itemsArray.append(productName!)
                    }
                    if(primaryKey == "readyInMinutes") {
                        let cookingMinutes = primaryValue.int
                        self.itemsPreparation.append(cookingMinutes!)
                    }
                }
            }
            
            self.collectionView.reloadData()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    
        self.itemsArray.removeAll()
        let query = self.searchBar.text!

        let recipeParameters: Parameters = [
            "limitLicense": "true",
            "number": 15,
            "query": query,
            "type": "main course"
        ]
    
        Alamofire.request("\(searchRecipeUrl)", method: .get, parameters: recipeParameters, headers: recipeHeaders).responseJSON { response in
    
            guard response.result.isSuccess else {
                print()
                return
            }
    
            let jsonData = JSON(response.result.value!)
    
            let jsonProducts = jsonData["results"]
            let jsonProductsCount = jsonData["results"].count
            self.productsCount = jsonProductsCount
    
            //print(self.productsCount)
            //print(jsonProducts)
    
            for(key, value):(String, JSON) in jsonProducts {
                for (primaryKey, primaryValue):(String, JSON) in value {
                    if(primaryKey == "title") {
                        let productName = primaryValue.string
                        self.itemsArray.append(productName!)
                    }
                    if(primaryKey == "readyInMinutes") {
                        let cookingMinutes = primaryValue.int
                        self.itemsPreparation.append(cookingMinutes!)
                    }
                }
            }
            self.collectionView.reloadData()
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? RecipeItemCell else { fatalError() }
    
        let itemName = itemsArray[indexPath.row]
        let itemPreparation = itemsPreparation[indexPath.row]
    
        cell.recipeName.text = itemName
        cell.preparationLabel.text = String(itemPreparation)
        
        return cell
    }
}
