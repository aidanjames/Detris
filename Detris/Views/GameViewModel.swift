//
//  GameViewModel.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import Foundation

class GameViewModel: ObservableObject {
    @Published private var game = Game()
    
    var score: Int { game.score }
    var currentBlock: BlockShape { game.currentShape }
    var nextBlock: BlockShape { game.nextShape }
    var blockPile: [BlockShape] { game.blockPile }
    
    func addToBlockPile(block: BlockShape) {
        self.game.blockPile.append(block)
    }
}
