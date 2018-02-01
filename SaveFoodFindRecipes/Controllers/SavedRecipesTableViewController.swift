//
//  SavedRecipesTableViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SavedRecipesTableViewController: UITableViewController {
    
    var recipeIds = [String]()
    var recipeNames = [String]()
    var recipeImages = [URL]()
    var email: String = ""
    
    let ref = Database.database().reference().child("Saved_recipes")
    let userID = Auth.auth().currentUser!.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser()
        fetchSavedRecipes()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // Get saved recipes from Firebase
    func fetchSavedRecipes() {
        ref.child(userID).observe(.value, with: { snapshot in
            var tempIdsList = [String]()
            var tempNamesList = [String]()
            var tempImagesList = [URL]()
            let favorites = snapshot.value as? [String:NSDictionary]
            // For every recipe, store nid, name and image to lists
            for favorite in favorites! {
                tempIdsList.append(favorite.key)
                let name = favorite.value["name"]
                tempNamesList.append(name as! String)
                let image = (favorite.value["image"])
                let imageUrl = NSURL(string: image as! String)
                tempImagesList.append(imageUrl as! URL)
            }
            self.recipeIds = tempIdsList
            self.recipeNames = tempNamesList
            self.recipeImages = tempImagesList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
    }
    
    func currentUser() {
        var userEmail = (Auth.auth().currentUser?.email)!
        if let shortenedUser = userEmail.range(of: "@")?.lowerBound {
            let substring = userEmail[..<shortenedUser]
            email = String(substring)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCellIdentifier", for: indexPath) as? RecipeTableViewCell
        configure(cell: cell!, forItemAt: indexPath)

        return cell!
    }
    
    func configure(cell: RecipeTableViewCell, forItemAt indexPath: IndexPath) {
        // Set recipe name and default image
        cell.savedImageView?.image = #imageLiteral(resourceName: "Food")
        cell.savedTextLabel?.text = recipeNames[indexPath.row]
        
        // Get image from API
        ApiController.shared.recipeImage(url:recipeImages[indexPath.row]) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.savedImageView?.image = image
                cell.savedImageView?.layer.cornerRadius = 9.0
                cell.savedImageView?.clipsToBounds = true
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.ref.child(self.email).child(recipeIds[indexPath.row]).removeValue()
            recipeIds.remove(at: indexPath.row)
            recipeNames.remove(at: indexPath.row)
            recipeImages.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savedToDetails" {
            let detailViewController = segue.destination as! DetailViewController
            let index = tableView.indexPathForSelectedRow!.row
            detailViewController.id = recipeIds[index]
            detailViewController.hideSaveButton = true
        }
    }

}
