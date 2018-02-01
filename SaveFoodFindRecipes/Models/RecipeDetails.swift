//
//  RecipeDetails.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 16-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation
import FirebaseDatabase

//struct Attributes: Codable {
//    var holiday: [String]
//    var cuisine: [String]
//}

struct Images: Codable {
    var hostedLargeUrl: URL
}

struct Source: Codable {
    var sourceRecipeUrl: String
}

struct Details: Codable {
    var ingredientLines: [String]
    var name: String
    var yield: String!
    var totalTime: String
    //var attributes: Attributes
    var id: String
    var images: [Images]
    var source: Source
    
    
//    func toAnyObject() -> Any {
//        return [
//            "name": name,
//            "id": id,
//            "images": images
//        ]
//    }
}



