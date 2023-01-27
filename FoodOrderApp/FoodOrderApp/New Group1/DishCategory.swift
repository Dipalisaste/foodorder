//
//  DishCategory.swift
//  FoodOrderApp
//
//  Created by Felix-ITS015 on 21/10/1944 Saka.
//  Copyright © 1944 Felix. All rights reserved.
//

import UIKit

struct DishCategory: Decodable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Decodable {
    let idCategory, strCategory: String?
    let strCategoryThumb: String?
    let strCategoryDescription: String?
}
