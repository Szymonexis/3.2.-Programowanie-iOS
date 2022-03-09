//
//  main.swift
//  Zajecia3
//
//  Created by Szymon Kaszuba-Gałka on 09/03/2022.
//

import Foundation

func getCSVData() -> [[String]] {
    let file = "csv_file.csv"
    // change path accordingly
    let fileURL = URL(fileURLWithPath: "/Users/molybdenum/Studia/3.2.-Programowanie-iOS/Zajecia3/Zajecia3/" + file)
    
    var lines: [[String]] = [[]]
        do {
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            let myStrings = data.split(separator: "\n")
            for myString in myStrings {
                var line: [String] = []
                var substringLine: [Substring] = []
                substringLine = myString.split(separator: ",")
                for substring in substringLine {
                    line.append(String(substring))
                }
                lines.append(line)
            }
        } catch {
            print(error)
        }
    return lines.filter({elem in return elem != []})
}

func validate(data: [[String]], validators: [Validator]) -> [[Bool]] {
    var results: [[Bool]] = [[]]
    for blob in data {
        var result: [Bool] = []
        for (input, validator) in zip(blob, validators) {
            validator.setValueToValidate(val: input)
            result.append(validator.validate())
        }
        results.append(result)
    }
    return results.filter({elem in return elem != []})
}

var validators: [Validator] = [ValidatorInteger(), ValidatorBool(), ValidatorState(), ValidatorSet()]

print(validate(data: getCSVData(), validators: validators))

print(getCSVData())


