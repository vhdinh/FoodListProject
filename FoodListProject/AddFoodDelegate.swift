//
//  AddFoodDelegate.swift
//  FoodListProject
//
//  Created by Vu Dinh on 6/2/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import Foundation

protocol AddFoodDelegate: class {
    func addFoodInViewController(controller: DetailFoodViewController, didFinishEditingFood edited_food : Food)
    
}