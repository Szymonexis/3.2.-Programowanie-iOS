//
//  main.swift
//  Zajecia-6
//
//  Created by Szymon Kaszuba-Gałka on 30/03/2022.
//

import Foundation

let fieldTypes: [FieldType] = [FieldType.CreditCardNumber, FieldType.CVCCode, FieldType.Numbers]
var group: Group = Group(name: "cardGroup", fieldTypes: fieldTypes)

let values: [String] = ["0000111122223333", "123", "2137"]
group.newItem(values: values)

print(group.toString())
