//
//  SearchViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation
import UIKit
import SearchTextField

class SearchViewController: UIViewController {

    let apiController = ApiController()
    
    //var recipeResults: [Recipe]?
    
    var totalList = [String]()
    
    var ingredients = [Ingredient]()
    
    //var ingredient = "broccoli"
    
    //static let share = SearchViewController()
    
    @IBOutlet weak var ingredientTextField: SearchTextField!
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
//        ingredient = self.ingredientTextField.text!
//        print(ingredient)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiController.shared.ingredientsList { (ingredients) in
            if let ingredients = ingredients {
                //print(ingredients)
                for ingredient in ingredients {
                    self.totalList.append(ingredient.searchValue)
                }
                //print(self.totalList)
                self.ingredientTextField.filterStrings(self.totalList)
                //self.updateUI()
            }
            
        }
            
        //configureSimpleSearchTextField()
        
        //self.view.reloadData()
//        retrieve() { (recipes) in
//            if let recipes = recipes {
//                self.recipeResults = recipes
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
//    func ingredientSearch(completion: @escaping (String) -> Void) {
//        let ingredient1 = ingredientTextField.text!
//        completion(ingredient1)
//    }
    
//    func updateUI() {
//        for ingredient in ingredients {
//            self.totalList.append(ingredient.searchValue)
//        }
//        print(self.totalList)
//    }
    
//    func ingredientsList(completion: @escaping ([Ingredient]?) -> Void) {
//        let url = URL(string: "http://api.yummly.com/v1/api/metadata/ingredient?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            var data2 = data!
//            data2.removeFirst(27)
//            data2.removeLast(2)
//            let ingredients = try? jsonDecoder.decode([Ingredient].self, from: data2)
//            completion(ingredients)
//
//        }
//        task.resume()
//    }
    
//    fileprivate func configureSimpleSearchTextField() {
//        // Start visible even without user's interaction as soon as created - Default: false
//        //ingredientTextField.startVisibleWithoutInteraction = true
//
//        // Set data source
//        ingredientTextField.filterStrings(self.totalList)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func retrieve(completion: @escaping ([Recipe]?) -> Void) {
//        let url = URL(string: "http://api.yummly.com/v1/api/recipes?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e&allowedIngredient[]=mushroom")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            let jsonDecoder = JSONDecoder()
//            if let data = data,
//                let recipes = try? jsonDecoder.decode(Recipes.self, from: data) {
//                completion(recipes.matches)
//                //print(recipes)
//            } else {
//                completion(nil)
//                print("nillll")
//            }
//
//        }
//        task.resume()
//    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResults" {
            let next = segue.destination as! ResultsTableViewController
            next.ingredient = self.ingredientTextField.text!
        }
    }
    

}
