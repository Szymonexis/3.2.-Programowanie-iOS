//
//  Group.swift
//  Zajecia-6
//
//  Created by Szymon Kaszuba-Gałka on 30/03/2022.
//

import Foundation

class Group {
    let name: String
    let fieldTypes: [FieldType]
    let items: [Item]
    
    init(name: String, fieldTypes: [FieldType]) {
        self.name = name
        self.fieldTypes = fieldTypes
        self.items = []
    }
    
    func newItem(values: [String]) {
        let item: Item = Item(fieldTypes: fieldTypes)
        try? item.setValues(values: values)
    }
        
    func toString() -> String {
        var returnString: String = ""
        var counter: Int = 0
        for item in items {
            returnString += String(counter) + "\n"
            returnString += item.toString() + "\n"
            counter += 1
        }
        return returnString
    }
}
