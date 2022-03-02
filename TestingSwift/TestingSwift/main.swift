//
//  main.swift
//  TestingSwift
//
//  Created by Szymon Kaszuba-Gałka on 02/03/2022.
//

import Foundation

var intArray: [Int] = []
var enumArray: [AcceptionType] = []

var min: Int = 0
var max: Int = 0

print("Provide min value:")
if let minStr: Int = Int(readLine() ?? "0") {
    min = minStr >= 0 ? minStr : 0
}

print("Provide max value:")
if let maxStr: Int = Int(readLine() ?? "0") {
    max = maxStr >= min ? maxStr : min
}

 for i in (min...max) {
    intArray.append(i)
}

// acceptance - exercise 1
for elem in intArray {
    if elem % 3 == 0 {
        enumArray.append(AcceptionType.Accept)
    } else {
        enumArray.append(AcceptionType.Reject)
    }
}

print(intArray)

print("|", terminator: "")
for elem in enumArray {
    if elem == AcceptionType.Accept {
        print("+", terminator: "|")
    } else if elem == AcceptionType.Reject {
        print(".", terminator: "|")
    }
}
print("")

// sieve - exercise 2
for (index, elem) in intArray.enumerated() {
    if (elem == 0 || elem == 1) {
        intArray[index] = 0
    }
    if (elem != 0 && elem != 1) {
        for (indexNum, elemNum) in intArray.enumerated() {
            if elemNum % elem == 0
                && elemNum != elem
                && elemNum != 0
                && elemNum != 1 {
                intArray[indexNum] = 0
            }
        }
    }
}

print(intArray)
