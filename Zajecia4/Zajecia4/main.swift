//
//  main.swift
//  Zajecia4
//
//  Created by Szymon Kaszuba-Gałka on 16/03/2022.
//

import Foundation

let toBeParsed = "15 +4val - (3*5)"

var parser: Parser = Parser(calcString: toBeParsed)

print(parser.parse())
