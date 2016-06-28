//
//  PassBackDelegate.swift
//  
//
//  Created by Christopher Katnic on 7/24/15.
//
//

import Foundation

protocol PassBackDelegate {
    func passBackItem(item:AnyObject)
    func itemExistsInList(description:String) -> Bool
    func getItemFromListWithSku(sku:String) -> groceryItem
    
}