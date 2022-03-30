//
//  Item.swift
//  Zajecia-6
//
//  Created by Szymon Kaszuba-Gałka on 30/03/2022.
//

import Foundation

class Item {
    let fields: [Field]
    
    init(fieldTypes: [FieldType]) {
        var fields: [Field] = []
        
        for fieldType in fieldTypes {
            switch fieldType {
            case .CreditCardNumber:
                fields.append(CreditCardNumberField(name: "ccNumber"))
                break
            case .CVCCode:
                fields.append(CVCField(name: "cvcNumber"))
                break
            case .EMail:
                fields.append(CVCField(name: "email"))
                break
            case .Text:
                fields.append(CVCField(name: "text"))
                break
            case .Numbers:
                fields.append(CVCField(name: "numbers"))
                break
            }
        }
        
        self.fields = fields
    }
}
