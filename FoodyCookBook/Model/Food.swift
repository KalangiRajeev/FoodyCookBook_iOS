//
//  Recipe.swift
//  FoodyCookBook
//
//  Created by Admin on 26/04/21.
//  Copyright © 2021 Rajeev Kalangi. All rights reserved.
//

import Foundation

struct Food: Codable {
    let meals : [Recipe]
}

struct Recipe: Codable {
    let idMeal : String
    let strMeal : String
    let strCategory : String
    let strArea : String
    let strInstructions : String
    let strMealThumb : String
    let strYoutube : String
}
