//
//  Parser.swift
//  Zajecia4
//
//  Created by Szymon Kaszuba-Gałka on 16/03/2022.
//

import Foundation

class Parser {
    let calcStringChars: [Character];
    
    init(calcString: String) {
        calcStringChars = Array(calcString)
    }
    
    func parse() -> [(String, Types)] {
        var parsedChars: [(c: Character, t: Types)] = []
        for char in calcStringChars {
            switch char {
            case ".":
                parsedChars.append((char, Types.dot))
                break
            case " ":
                parsedChars.append((char, Types.space))
                break
            case "(", ")":
                switch char {
                case "(":
                    parsedChars.append((char, Types.bracket(type: Bracket.opening)))
                    break
                case ")":
                    parsedChars.append((char, Types.bracket(type: Bracket.closing)))
                    break
                default:
                    break
                }
                break
            case "+", "-", "*", "/":
                switch char {
                case "+":
                    parsedChars.append((char, Types.operand(type: Operand.plus)))
                    break
                case "-":
                    parsedChars.append((char, Types.operand(type: Operand.minus)))
                    break
                case "*":
                    parsedChars.append((char, Types.operand(type: Operand.times)))
                    break
                case "/":
                    parsedChars.append((char, Types.operand(type: Operand.divide)))
                    break
                default:
                    break
                }
                break
            default:
                if (char.isNumber) {
                    parsedChars.append((char, Types.digit))
                } else {
                    parsedChars.append((char, Types.char))
                }
                break
            }
        }
        
        var parsedStrings: [(s: String, t: Types)] = []
        
        var number: String = ""
        var identifier: String = ""
        
        var dotFlag: Bool = false
        var operandFlag: Bool = false
        
        for tuple in parsedChars {
            switch tuple.t {
            case Types.digit, Types.dot:
                if (identifier != "") {
                    parsedStrings.append((identifier, Types.identifier))
                    identifier = ""
                }
                number += String(tuple.c)
                break
            case Types.char:
                if (number != "") {
                    parsedStrings.append((number, Types.number))
                    number = ""
                }
                identifier += String(tuple.c)
                break
            case Types.space:
                break
            default:
                if (number != "") {
                    parsedStrings.append((number, Types.number))
                    number = ""
                } else if (identifier != "") {
                    parsedStrings.append((identifier, Types.identifier))
                    identifier = ""
                }
                parsedStrings.append((String(tuple.c), tuple.t))
                break
            }
        }
        
        if (number != "") {
            parsedStrings.append((number, Types.number))
            number = ""
        } else if (identifier != "") {
            parsedStrings.append((identifier, Types.identifier))
            identifier = ""
        }
        
        return parsedStrings
    }
}
