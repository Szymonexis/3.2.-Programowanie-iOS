//
//  Board.swift
//  BattleshipGameEngine
//
//  Created by Szymon Kaszuba-Gałka on 23/02/2022.
//

import Foundation

class Board {
    let rows, cols: Int
    var grid: [[CellType]]
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols

        grid = []
        for col in 0...cols {
            for row in 0...rows {
                grid[col][row] = CellType.NotUsed
            }
        }
    }
}
