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
    #warning("Do not initialise blockPile when you actually start testing")
    var blockPile: [BlockShape] = PreviewMockData.shared.blockPile
    
    init() {
        self.currentShape = Game.generateRandomBlockShape()
        self.nextShape = Game.generateRandomBlockShape()
    }
    
    static func generateRandomBlockShape() -> BlockShape {
        return SquareBlock()
    }
}
