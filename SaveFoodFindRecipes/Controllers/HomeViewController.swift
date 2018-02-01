//
//  HomeViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var congratulations: UILabel!
    let ref3 = Database.database().reference().child("Points")
    let userID = Auth.auth().currentUser!.uid
    var points = [Points]()

    @IBAction func LogoutButtonTapped(_ sender: UIButton) {
        // Logout user
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
                self.present(vc!, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButton.layer.cornerRadius = 5
        fetchPoints()
    }
    
    func fetchPoints() {
        // Get user's points for saved ingredients from firebase
        ref3.queryOrdered(byChild: "points").observe(.value, with: { snapshot in
            var oldPoints = [Points]()
            for item in snapshot.children {
                let user = Points(snapshot: item as! DataSnapshot)
                oldPoints.append(user)
            }
            self.points = oldPoints
            self.congratulations.text = "You've saved \(self.points[0].score) ingredients so far! Keep up the good work and stop food waste by using the ingredients you have at home!"
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
