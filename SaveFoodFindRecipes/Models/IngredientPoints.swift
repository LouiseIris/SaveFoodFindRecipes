//
//  IngredientPoints.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 29-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Points {
    let user: String
    var score: Int
    
    init(snapshot: DataSnapshot) {
        user = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        score = snapshotValue["points"] as! Int
    }
}
