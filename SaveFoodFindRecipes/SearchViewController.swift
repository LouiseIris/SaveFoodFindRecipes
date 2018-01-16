//
//  SearchViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var recipeResults: [Recipe]?
    
    @IBOutlet weak var ingredientTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieve() { (recipes) in
            if let recipes = recipes {
                self.recipeResults = recipes
            }
        }
        print("has retrieved")
        print(recipeResults)
        print(self.recipeResults)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieve(completion: @escaping ([Recipe]?) -> Void) {
        let url = URL(string: "http://api.yummly.com/v1/api/recipes?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e&allowedIngredient[]=mushroom")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let recipes = try? jsonDecoder.decode(Recipes.self, from: data) {
                completion(recipes.matches)
                print(recipes)
            } else {
                completion(nil)
                print("nillll")
            }
            
        }
        task.resume()
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "buttonToResults" {
            let next = segue.destination as! ResultsTableViewController
            next.recipeResults = recipeResults
        }
    }
    

}
