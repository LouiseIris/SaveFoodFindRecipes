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
    //var savedList = []
    
    let ref = Database.database().reference().child("Saved_recipes")
    //var dataRef = Database.database().reference(email)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataRef.observeSingleEvent(of: .value, with: { snapshot in
//            self.savedList = []
//            //let recipeName = snapshot.childSnapshot(forPath: "name").value
//            for recipes in snapshot.children.allObjects as! [DataSnapshot] {
//                let recipeID = events.value as? [String: AnyObject]
//                let recipeName = eventObject?["name"]
//                let recipeImage = eventObject?["image"]
//            }
//        })
        
        
        currentUser()
        ref.child(email).observe(.value, with: { snapshot in
            print(snapshot.value)
            let favorites = snapshot.value as? [String:NSDictionary]
            print(favorites)
            
            for favorite in favorites! {
                self.recipeIds.append(favorite.key)
                let name = favorite.value["name"]
                self.recipeNames.append(name as! String)
                let image = (favorite.value["image"])
                let imageUrl = NSURL(string: image as! String)
                self.recipeImages.append(imageUrl as! URL)
                //self.recipeName.append(favorite.key["name"])
                print("jeej")
            }
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCellIdentifier", for: indexPath)

        // Configure the cell...
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = recipeNames[indexPath.row]
        ApiController.shared.recipeImage(url:recipeImages[indexPath.row]) { (image) in
            guard let image = image else {return}
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.imageView?.image = image
                cell.imageView?.layer.cornerRadius = 9.0
                cell.imageView?.clipsToBounds = true
                self.tableView.reloadData()
            }
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
