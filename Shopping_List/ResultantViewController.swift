//
//  ResultantViewController.swift
//  Shopping_List
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

import Foundation
import UIKit

class ResultantViewController: UIViewController {
    
    @IBOutlet weak var itemLocation: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemName: UILabel!
    
    var receievedItem: groceryItem = groceryItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemName.text = receievedItem.description
        itemPrice.text = receievedItem.price
        itemLocation.text = receievedItem.store
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
