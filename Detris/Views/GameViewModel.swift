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
    var timer: Timer?
    
    init() {
        startGame()
    }
    
    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: game.timeInterval, repeats: true) { timer in
            self.moveCurrentBlockDown()
        }
    }
    
    func pauseGame() {
        timer?.invalidate()
    }
    
    func incrementScoreBy(amount: Int) {
        game.score += amount
    }
    
    func incrementLevel() {
        game.level += 1
    }
    
    func addToBlockPile(block: BlockShape) {
        self.game.currentShape = nextBlock
        self.game.nextShape = Game.generateRandomBlockShape()
        self.game.blockPile.append(block)
    }
    
    func moveCurrentBlockLeft() {
        // Don't hit left wall
        guard !currentBlock.currentPosition.contains(where: { ($0 - 1) % 10 == 0 }) else { return }
        // Don't hit block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position - 1) { return }
            }
            
        }
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 - 1 }
    }
    
    func moveCurrentBlockRight() {
        // Don't hit right wall
        guard !currentBlock.currentPosition.contains(where: { $0 % 10 == 0 }) else { return }
        // Don't hit block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position + 1) { return }
            }
        }
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 + 1 }
    }
    
    func moveCurrentBlockDown() {
        // Don't go off the bottom
        guard !currentBlock.currentPosition.contains(where: { $0 > 200 } ) else {
            addToBlockPile(block: currentBlock)
            return
        }
        // Don't go through the block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position + 10) {
                    addToBlockPile(block: currentBlock)
                    return
                }
            }
        }
        
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 + 10 }
    }
    
    func flipCurrentBlock() {
        
    }
}
