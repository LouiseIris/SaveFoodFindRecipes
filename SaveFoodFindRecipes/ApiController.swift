//
//  ApiController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 16-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation
import UIKit

class ApiController {
    
    static let shared = ApiController()
    
    var id: String = ""
    
    var ingredient: String = ""
    
//    let searchViewController = SearchViewController()
//    var ingredient1 = String()
//    
//    SearchViewController.share.ingredientSearch { (ingredient1) in
//        let ingredient1 = ingredient1
//    }
    
    func ingredientsList(completion: @escaping ([Ingredient]?) -> Void) {
        let url = URL(string: "http://api.yummly.com/v1/api/metadata/ingredient?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            var data2 = data!
            data2.removeFirst(27)
            data2.removeLast(2)
            let ingredients = try? jsonDecoder.decode([Ingredient].self, from: data2)
            completion(ingredients)
            
        }
        task.resume()
    }
    
    func recipeResults(ingredient: String, completion: @escaping ([Recipe]?) -> Void) {
        let url = URL(string: "http://api.yummly.com/v1/api/recipes?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e&allowedIngredient[]=\(ingredient)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let results = try? jsonDecoder.decode(Recipes.self, from: data) {
                completion(results.matches)
                //print(recipes)
            } else {
                completion(nil)
                print("nillll")
            }
            
        }
        task.resume()
    }
    
    func detailsRecipe(id: String, completion: @escaping (Details?) -> Void) {
        let url = URL(string: "http://api.yummly.com/v1/api/recipe/\(id)?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let details = try? jsonDecoder.decode(Details.self, from: data) {
                completion(details)
            } else {
                completion(nil)
            }
            
        }
        task.resume()
    }
    
    func recipeImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

}
