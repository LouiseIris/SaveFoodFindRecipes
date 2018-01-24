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
    
    let apiController = ApiController()
    var details = {Details.self}
    var id: String = ""
    //var image = URL()
    var images = [Images]()
    //var temp = {Images}
    var name: String = ""
    var ingredientLines = [String]()
    
    var email: String = ""

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        print("1")
        ApiController.shared.detailsRecipe(id:id) { (details) in
            if let details = details {
                print("2")
                print(details)
                self.name = details.name
                self.ingredientLines = details.ingredientLines
                print(self.ingredientLines)
                DispatchQueue.main.async {
                    self.titleLabel.text = self.name
                }
                self.images = details.images
                //image = self.images[0].hostedLargeUrl
                print(self.images)
                ApiController.shared.recipeImage(url: self.images[0].hostedLargeUrl) { (image) in
                    guard let image = image  else {return}
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSaved" {
            let SavedRecipesTableViewController = segue.destination as! SavedRecipesTableViewController
            saveRecipe()
            SavedRecipesTableViewController.email = email
//            self.ref.child((Auth.auth().currentUser?.email)!).setValue(id)
//            self.ref.child((Auth.auth().currentUser?.email)!).setValue(name)
//            self.ref.child((Auth.auth().currentUser?.email)!).setValue(images[0].hostedLargeUrl)
//            SavedRecipesTableViewController.recipeId = id
//            SavedRecipesTableViewController.recipeName = name
//            SavedRecipesTableViewController.recipeImages = images
            //DetailViewController.image = recipeResults[index].smallImageUrls
        }
    }
    
    func saveRecipe() {
        var userEmail = (Auth.auth().currentUser?.email)!
        if let shortenedUser = userEmail.range(of: "@")?.lowerBound {
            let substring = userEmail[..<shortenedUser]
            email = String(substring)
            let largeImage = String(describing: images[0].hostedLargeUrl)
            print(largeImage)
            
            let child = ref.child(email).child(id).setValue(["name": name, "image": largeImage])
            //child.child(id).setValue(["name": name, "image": largeImage])
//            ref.child(email).setValue(name)
//            ref.child(email).setValue(largeImage)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
}
