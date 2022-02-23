//
//  main.swift
//  BattleshipGameEngine
//
//  Created by Szymon Kaszuba-Gałka on 23/02/2022.
//

import Foundation

// Nil-safe variables <-> Null-safety
var x = 5
var y: Int?
y = 5
print(y!)

let z = y ?? 0
print(z)
if let yy = y {
    print(yy)
} else {
    print("No value")
}

// Functions
func f1() {
    print("I am func f1")
}
f1()

func f2(parameterName: Int) {
    print(parameterName)
}
f2(parameterName: 12)

func f3(argumentLabel parameterName: Int) {
    print(parameterName)
}
f3(argumentLabel: 12)

func f4(_ parameterName: Int) {
    print(parameterName)
}
f4(12)
