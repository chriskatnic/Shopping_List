//
//  ViewController.swift
//  Shopping_List
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PassBackDelegate  {
    
    @IBOutlet weak var groceryListTable: UITableView!
    
    // MARK: Variable Definitions
    var gList: groceryList = groceryList()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryListTable.delegate = self
        groceryListTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // MARK: Test Functions
    func test() {
        // Testing tableview cells by adding a single item to array
        var test: groceryItem = groceryItem(d: "apple", p: "0.99", s: "Ralph's", st:"00010101")
        gList.addItem(test)
    }
    
    
    
    // MARK: Tableview Functions
    // The following tableview functions are mandatory
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gList.count()
    }
    
    
    
    
    // Populates tableviews with cells from an array
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = gList.getDescriptionOfItemAtIndex(indexPath.row)
        label.textAlignment = NSTextAlignment.Left
        
        let cell = UITableViewCell()
        cell.addSubview(label)
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("viewDetails", sender: indexPath)
        println("clicked item")
    }
    
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            gList.deleteItemAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    
    
    // MARK: Passback Protocol
    func passBackItem(item: AnyObject) {
        if let g = item as? groceryItem {
            println("g is a groceryitem")
            gList.addItem(g)
            groceryListTable.reloadData()
            
        }
    }
    
    func itemExistsInList(description: String) -> Bool {
        return gList.isItemInList(description)
    }
    
    func getItemFromListWithSku(sku: String) -> groceryItem {
        return gList.getItemWithSku(sku)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Is our destination the RVC?
        if let dVC = segue.destinationViewController as? ResultantViewController {
            let path = self.groceryListTable.indexPathForSelectedRow()!.row
            let item = gList.getItemAt(path)
            dVC.receievedItem = item
        }
        // Is our destination the BCVC?
        if let dVC = segue.destinationViewController as? BCViewController {
            println("Destination is barcode scanner")
            dVC.delegate = self
        }
        
    }
    
    
    
    
    
}

