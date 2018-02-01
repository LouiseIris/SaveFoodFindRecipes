//
//  DetailViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ref = Database.database().reference().child("Saved_recipes")
    let ref2 = Database.database().reference().child("Grocery_list")
    let ref3 = Database.database().reference().child("Points")
    let userID = Auth.auth().currentUser!.uid
    
    let apiController = ApiController()
    var details = {Details.self}
    var id: String = ""
    var images = [Images]()
    var name: String = ""
    var ingredientLines = [String]()
    var link: String = ""
    
    var email: String = ""
    var hideSaveButton: Bool = false
    var points = [Points]()

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func WebLink(_ sender: Any) {
        if let url = NSURL(string: link) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveRecipe()
        let alertController = UIAlertController(title: nil, message: "Recipe has been added to favorites", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchPoints()
        fetchDetails()
        
        // Hide save button if showing details of saved recipe
        if hideSaveButton == true {
            saveButton.isEnabled = false
            saveButton.tintColor = UIColor.clear
        }
    }
    
    // Get points from user's Firebase
    func fetchPoints() {
        ref3.queryOrdered(byChild: "points").observe(.value, with: { snapshot in
            print(snapshot.children)
            var oldPoints = [Points]()
            for item in snapshot.children {
                print(item)
                let user = Points(snapshot: item as! DataSnapshot)
                oldPoints.append(user)
                print(oldPoints)
            }
            self.points = oldPoints
        })
    }
    
    // Get recipe details from Yummly API
    func fetchDetails() {
        ApiController.shared.detailsRecipe(id:id) { (details) in
            if let details = details {
                self.name = details.name
                self.ingredientLines = details.ingredientLines
                self.link = details.source.sourceRecipeUrl
                DispatchQueue.main.async {
                    self.titleLabel.text = self.name
                    self.tableView.separatorStyle = .none
                    self.tableView.reloadData()
                }
                self.images = details.images
                self.fetchImage()
            }
        }
    }
    
    // Get large image from Yummly API
    func fetchImage() {
        ApiController.shared.recipeImage(url: self.images[0].hostedLargeUrl) { (image) in
            guard let image = image  else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    // Save recipe to Firebase
    func saveRecipe() {
        let largeImage = String(describing: images[0].hostedLargeUrl)
        let child = ref.child(userID).child(id).setValue(["name": name, "image": largeImage])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    // Set ingredient lines in table view
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        cell.textLabel?.text = ingredientLines[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLines.count
    }
    
    // Alert with options to add the ingredient to the grocery list, get a point or cancel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Ingredient", message: ingredientLines[indexPath.row], preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add To Grocery List", style: .destructive) { action in
            let item = self.ingredientLines[indexPath.row]
            // Save ingredient to grocery list on Firebase
            let child = self.ref2.child(self.userID).child(item).setValue(["item": item])
        }
        alertController.addAction(addAction)
        
        let homeAction = UIAlertAction(title: "Have It At Home", style: .destructive) { action in
            // Add a point and change it in Firebase
            self.points[0].score += 1
            let child = self.ref3.child(self.userID).setValue(["points": self.points[0].score])
        }
        alertController.addAction(homeAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
