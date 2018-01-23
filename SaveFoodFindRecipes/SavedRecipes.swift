//
//  SavedRecipes.swift
//  SaveFoodFindRecipes
//
//  Created by Iris Schlundt Bodien on 22-01-18.
//  Copyright © 2018 Iris Schlundt Bodien. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Saved: Codable {
    var image: String
    var name: String
    
//    init(snapshot: DataSnapshot) {
//        user = snapshot.key
//        id = user.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as! String
//        addedByUser = snapshotValue["addedByUser"] as! String
//        completed = snapshotValue["completed"] as! Bool
//        ref = snapshot.ref
    }
}
