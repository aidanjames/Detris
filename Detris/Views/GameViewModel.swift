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
    var level: Int { game.level }
    var interval: Double { game.timeInterval }
    var timer: Timer?
    @Published var inprogress: Bool = false
    
    init() {
        startGame()
    }
    
    func startGame() {
        inprogress = true
        timer = Timer.scheduledTimer(withTimeInterval: game.timeInterval, repeats: true) { timer in
            self.moveCurrentBlockDown()
        }
    }
    
    func pauseGame() {
        inprogress = false
        timer?.invalidate()
    }
    
    func incrementScoreBy(amount: Int) {
        game.score += amount
    }
    
    func incrementLevel() {
        guard game.timeInterval > 0.05 else {
            return
        }
        game.level += 1
        pauseGame()
        game.timeInterval -= 0.05
        startGame()
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
        switch currentBlock.blockType {
        case .straightBlock:
            if currentBlock.flipCount.isMultiple(of: 2) {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 18]
                let proposedFlip2 = [currentBlock.currentPosition[0] + 22, currentBlock.currentPosition[1] + 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 11]
                let proposedFlip3 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 27]
                let proposedFlip4 = [currentBlock.currentPosition[0] + 33, currentBlock.currentPosition[1] + 22, currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip4) {
                    game.currentShape.currentPosition = proposedFlip4
                    game.currentShape.flipCount += 1
                }
            } else {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 18]
                let proposedFlip2 = [currentBlock.currentPosition[0] - 22, currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 11]
                let proposedFlip3 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 27]
                let proposedFlip4 = [currentBlock.currentPosition[0] - 33, currentBlock.currentPosition[1] - 22, currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip4) {
                    game.currentShape.currentPosition = proposedFlip4
                    game.currentShape.flipCount += 1
                }
            }
        case .squareBlock:
            return
        case .tBlock:
            if currentBlock.flipCount == 0 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] + 9]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2] - 22, currentBlock.currentPosition[3] - 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 11]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] - 9]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                    print("We're now in flipCount 3")
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 11]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
            }
        case .lBlock:
            if currentBlock.flipCount == 0 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] - 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2] - 22, currentBlock.currentPosition[3] - 13]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 20]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 29]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] + 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                    print("We're now in flipCount 3")
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 20]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 29]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
            }
        case .reverseLBlock:
            if currentBlock.flipCount == 0 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] + 20]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2] - 22, currentBlock.currentPosition[3] + 9]
                let proposedFlip3 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1] - 20, currentBlock.currentPosition[2] - 31, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 11]
                let proposedFlip3 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1] - 2, currentBlock.currentPosition[2] + 7, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount = 2
                    print("We're now in flipCount 2")
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] - 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                    print("We're now in flipCount 3")
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 11]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
            }
        case .lSkewBlock:
            if currentBlock.flipCount == 0 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 2, currentBlock.currentPosition[1] + 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 9]
                let proposedFlip2 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 20]
                let proposedFlip3 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1] - 20, currentBlock.currentPosition[2] - 31, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                }
                else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                    print("We're now in flipCount 1")
                }
//                else if flipAllowed(newPosition: proposedFlip3) {
//                    game.currentShape.currentPosition = proposedFlip3
//                    game.currentShape.flipCount = 1
//                    print("We're now in flipCount 1")
//                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 2, currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 9]
                let proposedFlip2 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] + 2]
                let proposedFlip3 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] - 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
                else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
                else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount = 0
                    print("We're now in flipCount 0")
                }
            }
//            else if currentBlock.flipCount == 2 {
//                let proposedFlip1 = [currentBlock.currentPosition[0] - 20, currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 11]
//                if flipAllowed(newPosition: proposedFlip1) {
//                    game.currentShape.currentPosition = proposedFlip1
//                    game.currentShape.flipCount = 3
//                    print("We're now in flipCount 3")
//                }
//            } else if currentBlock.flipCount == 3 {
//                let proposedFlip1 = [currentBlock.currentPosition[0] + 2, currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 9]
//                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 11]
//                if flipAllowed(newPosition: proposedFlip1) {
//                    game.currentShape.currentPosition = proposedFlip1
//                    game.currentShape.flipCount = 0
//                    print("We're now in flipCount 0")
//                } else if flipAllowed(newPosition: proposedFlip2) {
//                    game.currentShape.currentPosition = proposedFlip2
//                    game.currentShape.flipCount = 0
//                    print("We're now in flipCount 0")
//                }
//            }
        case .rSkewBlock:
            print("TODO")
        }
    }
    
    func flipAllowed(newPosition: [Int]) -> Bool {
        print("Proposing \(newPosition)")
        // Will it go through the bottom?
        for position in newPosition {
            if position > 210 {
                print("We can't flip because it will fall through the floor.")
                return false
            }
        }
        
        // Will it go through the wall?
        var rightBoundary = false
        var leftBoundary = false
        for position in newPosition {
            if position % 10 == 0 {
                rightBoundary = true
            } else if (position - 1) % 10 == 0 {
                leftBoundary = true
            }
        }
        if leftBoundary && rightBoundary {
            print("We can't flip because it will go through the wall.")
            return false
        }
        
        // Will it go through the block pile?
        for block in blockPile {
            for position in newPosition {
                if block.currentPosition.contains(position) {
                    print("We can't flip because it will collide with the block pile.")
                    return false
                }
            }
        }
        return true
    }
}
