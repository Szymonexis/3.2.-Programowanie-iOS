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
    
    func newItem() {
        // TODO: finnish this bitch :3
    }
        
}
