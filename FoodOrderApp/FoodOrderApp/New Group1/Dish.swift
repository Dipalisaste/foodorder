//
//  Dish.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 21/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

struct Dish: Decodable {
    let meals: [Meal]?
}

// MARK: - Category
struct Meal: Decodable {
    
    let strMeal:String?
    let strMealThumb:String?
    let idMeal:String?
    
}
