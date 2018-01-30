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
    var totalList = [String]()
    var ingredients = [Ingredient]()
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var ingredientTextField: SearchTextField!
    @IBOutlet weak var ingredientTextField2: SearchTextField!
    @IBOutlet weak var ingredientTextField3: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 5
        fetchIngredienList()
    }
    
    func fetchIngredienList() {
        // Get list with all possible ingredients from Yummly-API
        ApiController.shared.ingredientsList { (ingredients) in
            if let ingredients = ingredients {
                for ingredient in ingredients {
                    self.totalList.append(ingredient.searchValue)
                }
                // Use ingredient list for dropdown menu in search text fields
                self.ingredientTextField.filterStrings(self.totalList)
                self.ingredientTextField2.filterStrings(self.totalList)
                self.ingredientTextField3.filterStrings(self.totalList)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send ingredients to ResultsViewController
        if segue.identifier == "toResults" {
            let next = segue.destination as! ResultsTableViewController
            next.ingredient = self.ingredientTextField.text!.replacingOccurrences(of: " ", with: "+")
            next.ingredient2 = self.ingredientTextField2.text!.replacingOccurrences(of: " ", with: "+")
            next.ingredient3 = self.ingredientTextField3.text!.replacingOccurrences(of: " ", with: "+")
        }
    }
    

}
