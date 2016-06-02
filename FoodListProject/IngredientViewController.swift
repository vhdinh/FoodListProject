//
//  IngredientViewController.swift
//  FoodListProject
//
//  Created by Vu Dinh on 5/16/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import UIKit
import CoreData

class IngredientViewController: UITableViewController, AddIngredientViewDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let app = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    var Ingredients = [Ingredient]()
    
    //navigation label to have custom title
    @IBOutlet weak var NavigationTitleLabel: UINavigationItem!

    //cancel button to go back to main
    weak var cancelButtonDelegate: CancelButtonDelegate?
    
    var IngredientToEdit: Food?
    var IngredientToEditIndexPath: Int?
    
    @IBAction func cancelBarButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationTitleLabel.title = IngredientToEdit!.title
        
        if let foodie = IngredientToEdit {
            let thisIngreds = foodie.ingredients!.allObjects as! [Ingredient]
            Ingredients = thisIngreds
        }
        
        
        tableView.reloadData()

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("AYY")
        if segue.identifier == "addIngredient" {
            print("AGGGEGE")
            let controller = segue.destinationViewController as! AddIngredientViewController
            controller.delegate = self
        }
    }
    
    @IBAction func addButtonClicked(sender: AnyObject) {
        performSegueWithIdentifier("addIngredient", sender: UIBarButtonItem.self)
    }
    
    func addIngredientViewController(controller: AddIngredientViewController, didFinishAddingIngredient ingredient: String) {
//        dismissViewControllerAnimated(true, completion: nil)
        let entity = NSEntityDescription.entityForName("Ingredient", inManagedObjectContext: managedObjectContext)
        let inGRE = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        inGRE.setValue(ingredient, forKey: "title")
        inGRE.setValue(IngredientToEdit, forKey: "food")

        IngredientToEdit?.mutableSetValueForKey("ingredients").addObject(inGRE)
        
        app.saveContext()
        

        if let foodie = IngredientToEdit {
            let thisIngreds = foodie.ingredients!.allObjects as! [Ingredient]
            Ingredients = thisIngreds
        }
        
        tableView.reloadData()

    }
    
    
    
    
//    func fetchAllIngredients() {
//        let IngRequest = NSFetchRequest(entityName: "Ingredient")
//        do {
//            let ingredients = try managedObjectContext.executeFetchRequest(IngRequest)
//            
//            Ingredients = ingredients as! [Ingredient]
//            print(Ingredients)
//            
//        } catch {
//            print("\(error)")
//        }
//
//    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        dequeue cell from storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("IngredientCell")!
        //        if cell has txt label, set to model that is corresponding to row in array
        cell.textLabel?.text = Ingredients[indexPath.row].title
        //        return cell so Table view knows what to draw in each row
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection secion: Int) -> Int {
        return Ingredients.count
    }

    
//    Deleting an Ingredient
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(Ingredients[indexPath.row])
        app.saveContext()
        Ingredients.removeAtIndex(indexPath.row)
        tableView.reloadData()
        
    }
    
}
