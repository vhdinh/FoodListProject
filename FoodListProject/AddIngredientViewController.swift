//
//  AddIngredientViewController.swift
//  FoodListProject
//
//  Created by Vu Dinh on 5/16/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import UIKit
import CoreData

class AddIngredientViewController: UIViewController {
    
    weak var delegate : AddIngredientViewDelegate?
    
    @IBOutlet weak var TextInputField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("IN ADD INGREDIENT")
    }
    
    @IBAction func DoneButtonPressed(sender: UIBarButtonItem) {
        print(TextInputField.text)
        
        let ingredient = TextInputField.text!
        if strlen(ingredient) > 1 {
            delegate?.addIngredientViewController(self, didFinishAddingIngredient: ingredient)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
