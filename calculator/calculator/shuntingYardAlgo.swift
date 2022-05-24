//
//  main.swift
//  ShuntingYardAlgorithm
//
//  Created by Szymon Kaszuba-Gałka on 24/05/2022.
//

import Foundation

let leftBraceString = "("
let rgihtBraceString = ")"
let powerString = "^"
let multiplyString = "x"
let divideString = "/"
let substractString = "-"
let addString = "+"

var precedenceDict: [String:Int] = [
    leftBraceString: 5,
    rgihtBraceString: 5,
    powerString: 4,
    multiplyString: 3,
    divideString: 3,
    substractString: 2,
    addString: 2
]

var operatorEnumDict: [String:OperatorEnum] = [
    powerString: OperatorEnum.power,
    multiplyString: OperatorEnum.multiply,
    divideString: OperatorEnum.divide,
    substractString: OperatorEnum.substract,
    addString: OperatorEnum.add
]

protocol ExpressionElement {
    func get() -> String
    func set(value: String) -> Void
}

class Number: ExpressionElement, CustomStringConvertible {
    var val: Float
    
    init(value: String) {
        val = Float(value)!
    }
    
    func get() -> String {
        return String(val)
    }
    
    func set(value: String) -> Void {
        val = Float(value)!
    }
    
    public var description: String { return "\(val)" }
}

class Operator: ExpressionElement, CustomStringConvertible {
    var val: String
    
    init(value: String) {
        val = value
    }
    
    func get() -> String {
        return val
    }
    
    func set(value: String) -> Void {
        val = value
    }
    
    func getPrecedence() -> Int {
        if (val != "(" && val != ")") {
            return precedenceDict[val]!
        }
        return 0
    }
    
    public var description: String { return "\(val)" }
}

enum OperatorEnum: String {
    case power = "^"
    case multiply = "x"
    case divide = "/"
    case add = "+"
    case substract = "-"
    case leftBrace = "("
    case rightBrace = ")"
}

class ShuntingYardAlgo {
    var output: [ExpressionElement] = []
    var opStack: [Operator] = []
    var valuesStack: [Number] = []
    var values: [ExpressionElement] = []
    var isRpn: Bool = false
    let operators: [String] = ["^", "x", "/", "-", "+", "(", ")"]

    init(expression: String) {
        let substrings = expression.split(separator: " ")
        for sequence in substrings {
            if (operators.contains(String(sequence))) {
                values.append(Operator(value: String(sequence)))
            } else {
                values.append(Number(value: String(sequence)))
            }
        }
    }
    
    func printCurrentState(printOutput: Bool? = true,
                           printOpStack: Bool? = true,
                           printValues: Bool? = true,
                           printValuesStack: Bool? = false,
                           value: String? = nil,
                           text: String? = nil) -> Void {
        if (printOutput != nil && printOutput!) {
            print("output: \(output)")
        }
        if (printOpStack != nil && printOpStack!) {
            print("opStack: \(opStack)")
        }
        if (printValues != nil && printValues!) {
            print("values: \(values)")
        }
        if (printValuesStack != nil && printValuesStack!) {
            print("valuesStack: \(valuesStack)")
        }
        if (value != nil) {
            print("Current value: \(value!)")
        }
        if (text != nil) {
            print(text!)
        }
    }
    
    func shunt() -> Void {
        for value in values {
            print("\n")
            if (value is Number) {
                output.append(value)
            } else {
                let op: Operator = Operator(value: value.get())
                if (opStack.isEmpty || op.get() == "(") {
                    opStack.append(op)
                } else {
                    if (op.get() == ")") {
                        var lastOperator = opStack.popLast()
                        while (lastOperator!.get() != "(") {
                            output.append(lastOperator!)
                            lastOperator = opStack.popLast()
                        }
                    } else if (op.getPrecedence() > opStack.last!.getPrecedence()
                               || opStack.last!.getPrecedence() == 0) {
                        opStack.append(op)
                    } else {
                        var lastOperator = opStack.last
                        while(lastOperator != nil
                              && op.getPrecedence() <= lastOperator!.getPrecedence()) {
                            output.append(opStack.popLast()!)
                            lastOperator = opStack.last
                        }
                        opStack.append(op)
                    }
                }
            }
        }
        
        while (!opStack.isEmpty) {
            let op = opStack.popLast()!;
            output.append(op)
        }
        
        var numberCount = 0
        var operatorCount = 0
        
        for value in output {
            if value is Number {
                numberCount += 1
            }
            if value is Operator {
                operatorCount += 1
            }
        }
        
        isRpn = (numberCount == (operatorCount + 1));
    }
    
    func solveRpn() -> Float {
        if (isRpn) {
            for value in output {
                if (value is Number) {
                    valuesStack.append(Number(value: value.get()))
                } else {
                    let rightValue = valuesStack.popLast()!
                    let leftValue = valuesStack.popLast()!
                    
                    let rightValueFloat = Float(rightValue.get())!
                    let leftValueFloat = Float(leftValue.get())!
                    var result: Float = -0.0
                    
                    let op: OperatorEnum = operatorEnumDict[value.get()]!
                    
                    switch op {
                    case .power:
                        result = pow(leftValueFloat, rightValueFloat)
                        break
                    case .multiply:
                        result = leftValueFloat * rightValueFloat
                        break
                    case .divide:
                        if (rightValueFloat == 0) {
                            return -0.0
                        }
                        result = leftValueFloat / rightValueFloat
                        break
                    case .add:
                        result = leftValueFloat + rightValueFloat
                        break
                    case .substract:
                        result = leftValueFloat - rightValueFloat
                        break
                    case .leftBrace:
                        break
                    case .rightBrace:
                        break
                    }
                    
                    valuesStack.append(Number(value: String(result)))
                }
            }
            return Float(valuesStack.popLast()!.get())!
        }
        return -0.0;
    }
}
