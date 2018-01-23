//
//  LogInViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {
    
    //var totalList = [String]()
    
    @IBOutlet weak var emailLoginTextField: UITextField!
    
    @IBOutlet weak var passwordLoginTextField: UITextField!
    
    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        // source: https://appcoda.com/firebase-login-signup/
        
        if self.emailLoginTextField.text == "" || self.passwordLoginTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            // sign in
            Auth.auth().signIn(withEmail: self.emailLoginTextField.text!, password: self.passwordLoginTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the StartViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarC")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    // if sign in wasn't successfull print error to the console
                    print("an error")
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }

    }
    
    @IBAction func RegisterButtonTapped(_ sender: UIButton) {
        // source: https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2
        
        let alert = UIAlertController(title: "Register",
                                      message: "Register",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { action in
                                        let emailField = alert.textFields![0]
                                        let passwordField = alert.textFields![1]
                                        
                                        Auth.auth().createUser(withEmail: emailField.text!,
                                                                   password: passwordField.text!) { user, error in
                                                                    if error == nil {
                                                                        Auth.auth().signIn(withEmail: self.emailLoginTextField.text!,
                                                                                               password: self.passwordLoginTextField.text!)
                                                                    }
                                        }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "toTabBarController", sender: nil)
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toTabBarController" {
//            let next = segue.destination as! SearchViewController
//            next.totalList = totalList
//        }
//    }
    
    
}




