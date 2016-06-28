//
//  groceryItem.swift
//  Shopping_List
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

import Foundation

class groceryItem {
    
    var description: String
    var price:  String
    var store:  String
    var sku:    String
    
    // Initializers for grocery item
    init()  {
        description = ""
        price       = ""
        store       = ""
        sku         = ""
    }
    
    init(d: String, p: String, s: String, st: String)  {
        description = d
        price       = p
        store       = s
        sku         = st
        
    }
    
    deinit{
        // Cleanup code
    }
    
    
    func copy (left: groceryItem, right: groceryItem) -> groceryItem
    {
        left.sku = right.sku
        left.description = right.description
        left.price = right.price
        left.store = right.store
        
        return left
    }
    
}