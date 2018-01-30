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
    
    var email: String = ""
    var hideSaveButton: Bool = false
    var points = [Points]()
    var counter = 0

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        pleaseWait()
        if hideSaveButton == true {
            saveButton.isEnabled = false
            saveButton.tintColor = UIColor.clear
        }
        tableView.dataSource = self
        tableView.delegate = self
        
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
        
        ApiController.shared.detailsRecipe(id:id) { (details) in
            if let details = details {
                self.name = details.name
                self.ingredientLines = details.ingredientLines
                DispatchQueue.main.async {
                    self.titleLabel.text = self.name
                    self.tableView.separatorStyle = .none
                    self.tableView.reloadData()
                }
                self.images = details.images
                ApiController.shared.recipeImage(url: self.images[0].hostedLargeUrl) { (image) in
                    guard let image = image  else {return}
                    DispatchQueue.main.async {
                        self.imageView.image = image
//                        self.waitIsOver()
                    }
                }
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSaved" {
            let savedRecipesTableViewController = segue.destination as! SavedRecipesTableViewController
            saveRecipe()
            savedRecipesTableViewController.email = email
        }
    }
    
    // Source: https://stackoverflow.com/questions/27960556/loading-an-overlay-when-running-long-tasks-in-ios
    func pleaseWait() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func waitIsOver() {
        dismiss(animated: false, completion: nil)
    }
    
    func saveRecipe() {
        var userEmail = (Auth.auth().currentUser?.email)!
        if let shortenedUser = userEmail.range(of: "@")?.lowerBound {
            let substring = userEmail[..<shortenedUser]
            email = String(substring)
            let largeImage = String(describing: images[0].hostedLargeUrl)
            print(largeImage)
            
            let child = ref.child(email).child(id).setValue(["name": name, "image": largeImage])
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCellIdentifier", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        
        cell.textLabel?.text = ingredientLines[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code to execute on click
        let alertController = UIAlertController(title: "Ingredient", message: ingredientLines[indexPath.row], preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add To Grocery List", style: .destructive) { action in
            let item = self.ingredientLines[indexPath.row]
            print(item)
            let child = self.ref2.child(self.userID).child(item).setValue(["item\(self.counter)": item])
            self.counter += 1
        }
        alertController.addAction(addAction)
        let homeAction = UIAlertAction(title: "Have It At Home", style: .destructive) { action in
            self.points[0].score += 1
            let child = self.ref3.child(self.userID).setValue(["points": self.points[0].score])
        }
        alertController.addAction(homeAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
