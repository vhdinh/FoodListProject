//
//  DetailFoodViewController.swift
//  FoodListProject
//
//  Created by Vu Dinh on 6/2/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import UIKit
import CoreData

class DetailFoodViewController : UIViewController {
    
    var CurrentFood : Food?
    weak var cancelButtonDelegate : CancelButtonDelegate2?
    var editFood : AddFoodDelegate?
    
    @IBOutlet weak var textInput: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textInput.text = CurrentFood?.title

    }
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        let editedFood = textInput.text!
        if strlen(editedFood) > 1 {
            CurrentFood!.title = editedFood
            editFood?.addFoodInViewController(self, didFinishEditingFood: CurrentFood!)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
}
