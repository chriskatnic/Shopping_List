//
//  groceryList.swift
//  Shopping_List
//
//  Created by Christopher Katnic on 7/24/15.
//  Copyright (c) 2015 Christopher Katnic. All rights reserved.
//

import Foundation


class groceryList {
    
    // Currently using an array of groceryItems. Can use a dictionary, but speed is a nonissue. Grocery list will be <30 items
    var itemList: [groceryItem]
    
    // MARK: Initializers
    init()  {
        itemList = []
        println("new list initialized with no input")
    }
    
    init(item: groceryItem) {
        itemList = []
        itemList.append(item)
    }
    
    deinit {
        println("list deinitialized")
    }
    
    
    // MARK: List functions
    func addItem(item: groceryItem) {
        itemList.append(item)
    }
    
    
    
    func deleteItemByDescription(description: String) {
        for index in 0..<itemList.count {
            if  itemList[index].description == description {
                itemList.removeAtIndex(index)
                println("removed \(description)")
            }
        }

    }
    
    
    
    func deleteItemAtIndex(index: Int) {
        itemList.removeAtIndex(index)
    }
    
    
    
    
    func getItemAt (index : Int) -> groceryItem {
        return itemList[index]
    }
    
    
    func getItemWithSku(sku: String) -> groceryItem {
        for index in 0..<itemList.count {
            if  itemList[index].sku == sku  {
                return itemList[index]
            }
        }
        
        return  groceryItem()
    }
    
    
    
    func count() -> Int {
        return itemList.count
    }
    
    
    
    
    func getDescriptionOfItemAtIndex(index: Int) -> String {
        return itemList[index].description
    }
    
    
    
    func isItemInList(description:  String) -> Bool {
        for index in 0..<itemList.count {
            if  itemList[index].description == description {
                return true
            }
        }
        return false

    }
    
    
}