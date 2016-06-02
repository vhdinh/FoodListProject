//
//  AddIngredientViewDelegate.swift
//  FoodListProject
//
//  Created by Vu Dinh on 5/16/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import Foundation

protocol AddIngredientViewDelegate: class {
    func addIngredientViewController(controller: AddIngredientViewController, didFinishAddingIngredient ingredient: String)
}