//
//  ItemDescriptionViewController.swift
//  Shopping_List
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

// TODO: Test new function to return data back from item description view controller to the main list
// check what else needs to be done for basic functionality


import UIKit

class ItemDescriptionViewController: UIViewController, UITextFieldDelegate {
    
    var itemCaptured: groceryItem?
    var delegate : ItemPassBackDelegate?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var storeField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        nameField.delegate = self
        storeField.delegate = self
        priceField.delegate = self
        
        if(itemCaptured == nil) {
            itemCaptured = groceryItem() }
        
        nameField.text  = itemCaptured!.description
        storeField.text = itemCaptured!.store
        priceField.text = itemCaptured!.price
        
        
        print("\(itemCaptured!.sku)")
        
    }
    
    
    
    
    
    @IBAction func storeData(sender: AnyObject) {
        
        // Create an item to be passed back with the user entered data
        let savedData = groceryItem(d: nameField.text, p: priceField.text, s: storeField.text, st: itemCaptured!.sku)
        
        // Send it back to the previous view controller
        delegate?.passBackItem(savedData)
        
    }
    
    
    
    
    
    // MARK: Text field keyboard dismiss
    func textFieldShouldReturn(textField: UITextField)-> Bool{
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
}