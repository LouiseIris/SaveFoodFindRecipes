//
//  RecipeData.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 14-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation

struct Recipe: Codable {
    var id: String
    var smallImageUrls: [URL]
    var recipeName: String
}

struct Recipes: Codable {
    let matches: [Recipe]
}
