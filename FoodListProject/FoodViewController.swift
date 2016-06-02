//
//  ViewController.swift
//  FoodListProject
//
//  Created by Vu Dinh on 5/16/16.
//  Copyright © 2016 Vu Dinh. All rights reserved.
//

import UIKit
import CoreData

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddFoodDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let app = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var Foods = [Food]()
    
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editFood", sender: tableView.cellForRowAtIndexPath(indexPath))
        print("HI")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("Hii")
//        print(sender)
        if segue.identifier == "editFood" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! IngredientViewController
            let indexPath = tableViewOutlet.indexPathForCell(sender as! UITableViewCell)
            controller.IngredientToEdit = Foods[indexPath!.row]
            controller.IngredientToEditIndexPath = indexPath!.row
        }
        if segue.identifier == "editCurrentFood" {
            let controller = segue.destinationViewController as! DetailFoodViewController
            let indexPath = tableViewOutlet.indexPathForCell(sender as! UITableViewCell)
            controller.CurrentFood = Foods[indexPath!.row]
            controller.editFood = self
            
        }
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.dataSource = self
        tableViewOutlet.delegate = self
        retrieveFood()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Foods.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCustomCell") as! foodCell
        cell.foodsLabel.text = Foods[indexPath.row].title!
        return cell
    }
    
    //adding food
    @IBAction func addButtonPressed(sender: AnyObject) {
        if textFieldOutlet.text != "" {
            let entity = NSEntityDescription.entityForName("Food", inManagedObjectContext: managedObjectContext)
            let newFood = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
            newFood.setValue(textFieldOutlet.text, forKey: "title")
            app.saveContext()
            textFieldOutlet.text = ""
            retrieveFood()
            tableViewOutlet.reloadData()
            
        }
    }
    
    //Editing a food title
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("editCurrentFood", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
    
    func addFoodInViewController(controller: DetailFoodViewController, didFinishEditingFood edited_food: Food) {
        print("BACK AT IT AGAIN", edited_food)
        app.saveContext()
        
//        retrieveFood()
        
        tableViewOutlet.reloadData()
    }
    
    
    
    //Delete a food
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //remove food at indexPath
        print("TRYING TO DELETE")
        managedObjectContext.deleteObject(Foods[indexPath.row])
        app.saveContext()
        Foods.removeAtIndex(indexPath.row)
        
        tableView.reloadData()
        
        retrieveFood()
        
    }
    
    //retrieve food
    func retrieveFood() {
        let request = NSFetchRequest(entityName: "Food")
        do {
            Foods = try managedObjectContext.executeFetchRequest(request) as! [Food]
        } catch {
            print("UH OH")
        }
    }
    
    

    
}

