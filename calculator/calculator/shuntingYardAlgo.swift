//
//  shuntingYardAlgo.swift
//  calculator
//
//  Created by Szymon Kaszuba-Gałka on 23/05/2022.
//

import Foundation

// great resource http://jsfiddle.net/7jh9f/2/

struct ShuntingYardAlgo {
    var output: [String] = []
    var operatorStack: [String] = []

    var valuesSubstr = "2 + 3 * 4 - 5 + 7 * 6 / 3 - 2 * 3 ^ 2 + ( 5 - 2 ) * 2".split(separator: " ")
    var values: [String] = []

    init(expression: String) {
        for sequence in valuesSubstr {
            values.append(String(sequence))
        }
    }
}
