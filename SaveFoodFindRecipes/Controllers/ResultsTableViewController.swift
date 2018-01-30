//
//  ResultsTableViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {

    var recipeResults = [Recipe]()
    var ingredient: String?
    var ingredient2: String?
    var ingredient3: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchResults()
    }
    
    func fetchResults() {
        
        // Make ingredientsstring useable for api call
        if ingredient2 != "" {
            ingredient = ingredient! + "&allowedIngredient[]=" + ingredient2!
        }
        if ingredient3 != "" {
            ingredient = ingredient! + "&allowedIngredient[]=" + ingredient3!
        }
        
        // Get recipe results with chosen ingredients from Yummly API
        ApiController.shared.recipeResults(ingredient: ingredient!) { (results) in
            if let results = results {
                DispatchQueue.main.async {
                    self.recipeResults = results
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsCellIdentifier", for: indexPath) as? RecipeTableViewCell
        configure(cell: cell!, forItemAt: indexPath)

        return cell!
    }
    
    func configure(cell: RecipeTableViewCell, forItemAt indexPath: IndexPath) {
        
        let recipeResult = recipeResults[indexPath.row]
        // Set recipe name and default image
        cell.nameLabel?.text = recipeResult.recipeName
        cell.photoView?.image = #imageLiteral(resourceName: "Food")
        
        // Get recipe image from Yummly API
        ApiController.shared.recipeImage(url:recipeResults[indexPath.row].smallImageUrls[0]) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                // Set new image
                cell.photoView?.image = image
                cell.photoView?.layer.cornerRadius = 5.0
                cell.photoView?.clipsToBounds = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Send id of selected recipe to DetailViewController
        if segue.identifier == "toDetails" {
            let DetailViewController = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            DetailViewController.id = recipeResults[index].id
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
