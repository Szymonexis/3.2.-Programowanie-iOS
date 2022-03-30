//
//  Field.swift
//  Zajecia-6
//
//  Created by Szymon Kaszuba-Gałka on 30/03/2022.
//

import Foundation

class Field {
    let name: String
    var value: Any? = nil
    
    init(name: String) {
        self.name = name
    }
    
    func setValue(value: Any) {
        if parseValue(val: value) {
            self.value = value
        } else {
            self.value = nil
        }
    }
    
    func parseValue(val: Any) -> Bool {
        return true
    }
}

class TextField: Field {
    override init(name: String) {
        super.init(name: name)
    }
    
    func setValue(value: String) {
        if parseValue(val: value) {
            self.value = value as String
        } else {
            self.value = nil
        }
    }
}

class EmailField: TextField {
    let regex: NSRegularExpression = try! NSRegularExpression(pattern: "^[a-z.0-9]{20}@[a-z]{1,7}[.][a-z]{1,5}$")
    
    override init(name: String) {
        super.init(name: name)
    }
    
    override func setValue(value: String) {
        if parseValue(val: value) {
            self.value = value as String
        } else {
            self.value = nil
        }
    }
    
    func parseValue(val: String) -> Bool {
        let regexResult = self.regex.firstMatch(in: val, range: NSRange(location: 0, length: val.utf16.count))
        if (regexResult != nil) {
            return true;
        }
        return false;
    }
}

class NumberField: Field {
    let regex: NSRegularExpression = try! NSRegularExpression(pattern: "^[0-9]*$")
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func setValue(value: String) {
        if parseValue(val: value) {
            self.value = value as String
        } else {
            self.value = nil
        }
    }
    
    func parseValue(val: String) -> Bool {
        let regexResult = self.regex.firstMatch(in: val, range: NSRange(location: 0, length: val.utf16.count))
        if (regexResult != nil) {
            return true;
        }
        return false;
    }
}

class CVCField: Field {
    let regex: NSRegularExpression = try! NSRegularExpression(pattern: "^[0-9]{3}$")
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func setValue(value: String) {
        if parseValue(val: value) {
            self.value = value as String
        } else {
            self.value = nil
        }
    }
    
    func parseValue(val: String) -> Bool {
        let val = self.value as! String
        let regexResult = self.regex.firstMatch(in: val, range: NSRange(location: 0, length: val.utf16.count))
        if (regexResult != nil) {
            return true;
        }
        return false;
    }
}

class CreditCardNumberField: Field {
    let regex: NSRegularExpression = try! NSRegularExpression(pattern: "^[0-9]{16}$")
    
    override init(name: String) {
        super.init(name: name)
    }
    
    func setValue(value: String) {
        if parseValue(val: value) {
            self.value = value as String
        } else {
            self.value = nil
        }
    }
    
    func parseValue(val: String) -> Bool {
        let val = self.value as! String
        let regexResult = self.regex.firstMatch(in: val, range: NSRange(location: 0, length: val.utf16.count))
        if (regexResult != nil) {
            return true;
        }
        return false;
    }
}
