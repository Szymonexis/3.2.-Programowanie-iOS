//
//  Validator.swift
//  Zajecia3
//
//  Created by Szymon Kaszuba-Gałka on 09/03/2022.
//

import Foundation

class Validator {
    var value: String
    
    init() {
        self.value = ""
    }
    
    init(val: String) {
        value = val
    }
    
    func setValueToValidate(val: String) {
        self.value = val
    }
    
    func validate() -> Bool {return false}
}

class ValidatorBool: Validator {
    override func validate() -> Bool {
        return (self.value == "F" || self.value == "T")
    }
}

class ValidatorInteger: Validator {
    override func validate() -> Bool {
        return Int(self.value) != nil
    }
}

class ValidatorSet: Validator {
    override func validate() -> Bool {
        return ["A", "B", "C", "D"].contains(self.value)
    }
}

class ValidatorState: Validator {
    override func validate() -> Bool {
        return (self.value == State.Yes.rawValue
                || self.value == State.No.rawValue
                || self.value == State.Unknown.rawValue)
    }
}
