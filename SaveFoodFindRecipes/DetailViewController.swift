//
//  DetailViewController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 11-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let apiController = ApiController()
    var details = {Details.self}
    var id: String = ""
    var image = [URL]()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("1")
        ApiController.shared.recipeImage(url: image[0]) { (image) in
            guard let image = image  else {return}
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        ApiController.shared.detailsRecipe(id:id) { (details) in
            if let details = details {
                print("2")
                print(details)
                DispatchQueue.main.async {
                    self.titleLabel.text = details.name
                }
                print("3")
                for ingredientLine in details.ingredientLines {
                    let ingredientButton = UIButton(type: UIButtonType.system)
                    ingredientButton.setTitle(ingredientLine, for: .normal)
                    self.view.addSubview(ingredientButton)
                }
            }
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

}
