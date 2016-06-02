//
//  IngredientViewControllerDelegate.swift
//  FoodListProject
//
//  Created by Vu Dinh on 5/16/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import Foundation

protocol IngredientViewControllerDelegate: class {
    
    func ingredientViewController(controller: IngredientViewController, didFinishAddingIngredient ingredient: String)
    func ingredientViewController(controller: IngredientViewController, didFinishEditingIngredient ingredient: String, atIndexPath indexPath: Int)
}