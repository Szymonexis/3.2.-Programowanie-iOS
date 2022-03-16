//
//  Types.swift
//  Zajecia4
//
//  Created by Szymon Kaszuba-Gałka on 16/03/2022.
//

import Foundation

enum Types {
    case operand (type: Operand)
    case bracket (type: Bracket)
    case digit
    case dot
    case space
    case char
    case number
    case identifier
}

enum Operand {
    case plus
    case minus
    case times
    case divide
}

enum Bracket {
    case opening
    case closing
}
