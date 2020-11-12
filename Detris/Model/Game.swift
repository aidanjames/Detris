//
//  Game.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import Foundation

struct Game {
    var score = 0
    var level = 1
    var currentShape: BlockShape
    var nextShape: BlockShape
    var blockPile: [BlockShape]
    
    static func generateRandomBlockShape() -> BlockShape {
        return SquareBlock()
    }
}
