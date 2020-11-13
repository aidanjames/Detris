//
//  Game.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import Foundation

#warning("Make ths conform to codable so can save the game")
struct Game {
    var score = 0
    var level = 1
    var timeInterval: Double = 1
    var currentShape: BlockShape
    var nextShape: BlockShape
    var blockPile: [BlockShape] = []
    
    init() {
        self.currentShape = Game.generateRandomBlockShape()
        self.nextShape = Game.generateRandomBlockShape()
    }
    
    static func generateRandomBlockShape() -> BlockShape {
        let randomBlockType = BlockType.allCases.randomElement()
        
        switch randomBlockType {
        case .straightBlock:
            return StraightBlock()
        case .squareBlock:
            return SquareBlock()
        case .tBlock:
            return TBlock()
        case .lBlock:
            return LBlock()
        case .reverseLBlock:
            return ReverseLBlock()
        case .lSkewBlock:
            return LSkewBlock()
        case .rSkewBlock:
            return RSkewBlock()
        default:
            fatalError("We shouldn't be here")
        }
    }
    
}

enum CurrentGame: String {
    case score = "CurrentGameScore"
    case level = "CurrentGameLevel"
    case timeInterval = "CurrentGameTimeInterval"
    case currentShape = "CurrentGameCurrentShape"
}
