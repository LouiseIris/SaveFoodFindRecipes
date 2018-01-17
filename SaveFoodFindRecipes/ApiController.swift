//
//  ApiController.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 16-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation

class ApiController {
    static let shared = ApiController()
    
    func ingredientsList(completion: @escaping ([Ingredient]?) -> Void) {
        let url = URL(string: "http://api.yummly.com/v1/api/metadata/ingredient?_app_id=6dc18156&_app_key=4ba69a9ccd8406d31f15f48886c69b0e")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            var data2 = data!
            data2.removeFirst(27)
            data2.removeLast(2)
            let ingredients = try? jsonDecoder.decode([Ingredient].self, from: data2)
            completion(ingredients)
            
        }
        task.resume()
    }

}
