//
//  Board.swift
//  BattleshipGameEngine
//
//  Created by Szymon Kaszuba-Gałka on 23/02/2022.
//

import Foundation

class Board {
    let rows, cols: Int
//    var grid: [[CellType]]
    init(givenRows: Int, givenCols: Int) {
        rows = givenRows
        cols = givenCols
    }
}
