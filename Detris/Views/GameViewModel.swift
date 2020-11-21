//
//  GameViewModel.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published private var game = Game()
    
    var score: Int { game.score }
    var currentBlock: BlockShape { game.currentShape }
    var nextBlock: BlockShape { game.nextShape }
    var blockPile: [BlockShape] { game.blockPile }
    var level: Int { game.level }
    var lines: Int { game.lines }
    var interval: Double { game.timeInterval }
    var highScore: Int { game.highScore }
    var timer: Timer?
    @Published var inprogress: Bool = false
    @Published var gamePaused: Bool = false
    @Published var gameOver: Bool = false
    
    
    init() {
        startGame()
    }
    
    func startGame() {
        game.score = 0
        game.level = 1
        game.lines = 0
        game.timeInterval = 1
        game.blockPile = []
        game.currentShape = Game.generateRandomBlockShape()
        game.nextShape = Game.generateRandomBlockShape()
        gameOver = false
        
        resumeGame()
    }
    
    func pauseGame() {
        inprogress = false
        gamePaused = true
        timer?.invalidate()
    }
    
    func resumeGame() {
        inprogress = true
        gamePaused = false
        timer = Timer.scheduledTimer(withTimeInterval: game.timeInterval, repeats: true) { timer in
            self.moveCurrentBlockDown()
        }
    }
    
    func incrementScoreBy(amount: Int) {
        withAnimation {
            game.score += amount
            if score > game.highScore {
                game.highScore = score
                UserDefaults.standard.set(game.highScore, forKey: "HighScore")
            }
        }
        checkLevel()
    }
    
    func checkLevel() {
        switch game.lines {
        case 10..<20:
            if level != 2 {
                game.level = 2
                reduceTimeInterval()
            }
        case 20..<30:
            if level != 3 {
                game.level = 3
                reduceTimeInterval()
            }
        case 30..<40:
            if level != 4 {
                game.level = 4
                reduceTimeInterval()
            }
        case 40..<50:
            if level != 5 {
                game.level = 5
                reduceTimeInterval()
            }
        case 50..<60:
            if level != 6 {
                game.level = 6
                reduceTimeInterval()
            }
        case 60..<70:
            if level != 7 {
                game.level = 7
                reduceTimeInterval()
            }
        case 70..<80:
            if level != 8 {
                game.level = 8
                reduceTimeInterval()
            }
        case 80..<90:
            if level != 9 {
                game.level = 9
                reduceTimeInterval()
            }
        case 90..<100:
            if level != 10 {
                game.level = 10
                reduceTimeInterval()
            }
        case 100..<110:
            if level != 11 {
                game.level = 11
                reduceTimeInterval()
            }
        case 110..<120:
            if level != 12 {
                game.level = 12
                reduceTimeInterval()
            }
        case 120..<130:
            if level != 13 {
                game.level = 13
                reduceTimeInterval()
            }
        case 130..<140:
            if level != 14 {
                game.level = 14
                reduceTimeInterval()
            }
        case 140...:
            if level != 15 {
                game.level = 15
                reduceTimeInterval()
            }
        default:
            game.level = 1
            game.timeInterval = 1
        }
        
        
        
    }
    
    func reduceTimeInterval() {
        guard game.timeInterval > 0.05 else {
            return
        }
        pauseGame()
        game.timeInterval -= 0.05
        resumeGame()
    }
    
    func addToBlockPile(block: BlockShape) {
        self.game.blockPile.append(block)
        self.game.currentShape = nextBlock
        self.game.nextShape = Game.generateRandomBlockShape()
        
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position) {
                    withAnimation {
                        gameOver = true
                    }
                    inprogress = false
                    pauseGame()
                }
            }
        }
    }
    
    func moveCurrentBlockLeft() {
        guard inprogress else { return }
        // Don't hit left wall
        guard !currentBlock.currentPosition.contains(where: { ($0 - 1) % 10 == 0 }) else { return }
        // Don't hit block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position - 1) { return }
            }
        }
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 - 1 }
        //        HapticsManager.shared.moveHaptic()
    }
    
    func moveCurrentBlockRight() {
        guard inprogress else { return }
        // Don't hit right wall
        guard !currentBlock.currentPosition.contains(where: { $0 % 10 == 0 }) else { return }
        // Don't hit block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position + 1) { return }
            }
        }
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 + 1 }
        //        HapticsManager.shared.moveHaptic()
    }
    
    func moveDownButtonPressed() {
        moveCurrentBlockDown()
        
        //        HapticsManager.shared.moveHaptic()
    }
    
    func moveCurrentBlockDown() {
        // Don't do anything if game over
        guard !gameOver else { return }
        guard inprogress else { return }
        
        // Don't go off the bottom
        guard !currentBlock.currentPosition.contains(where: { $0 > 200 } ) else {
            addToBlockPile(block: currentBlock)
            removeCompleteLines()
            return
        }
        // Don't go through the block pile
        for block in blockPile {
            for position in currentBlock.currentPosition {
                if block.currentPosition.contains(position + 10) {
                    addToBlockPile(block: currentBlock)
                    removeCompleteLines()
                    return
                }
            }
        }
        game.currentShape.currentPosition = currentBlock.currentPosition.map { $0 + 10 }
    }
    
    func removeCompleteLines() {
        // Assess if there are any complete lines. If so add them to an array [[Int]]
        var completedLInes = [[Int]]()
        var allPositionsInBlockPile = [[Int]]()
        
        for block in blockPile {
            allPositionsInBlockPile.append(block.currentPosition)
        }
        let allPositionsInBlockPileFlattened = allPositionsInBlockPile.joined().sorted()
        
        if Array(1...10).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(1...10)) }
        if Array(11...20).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(11...20)) }
        if Array(21...30).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(21...30)) }
        if Array(31...40).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(31...40)) }
        if Array(41...50).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(41...50)) }
        if Array(51...60).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(51...60)) }
        if Array(61...70).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(61...70)) }
        if Array(71...80).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(71...80)) }
        if Array(81...90).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(81...90)) }
        if Array(91...100).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(91...100)) }
        if Array(101...110).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(101...110)) }
        if Array(111...120).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(111...120)) }
        if Array(121...130).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(121...130)) }
        if Array(131...140).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(131...140)) }
        if Array(141...150).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(141...150)) }
        if Array(151...160).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(151...160)) }
        if Array(161...170).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(161...170)) }
        if Array(171...180).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(171...180)) }
        if Array(181...190).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(181...190)) }
        if Array(191...200).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(191...200)) }
        if Array(201...210).allSatisfy(allPositionsInBlockPileFlattened.contains) { completedLInes.append(Array(201...210)) }
        
        guard !completedLInes.isEmpty else { return }
        self.game.lines += completedLInes.count
        
        // Remove positions from the block pile if they are included in a completed line
        for i in 0..<blockPile.count {
            for position in completedLInes.joined() {
                if let index = self.game.blockPile[i].currentPosition.firstIndex(where: { $0 == position } ) {
                    self.game.blockPile[i].currentPosition.remove(at: index)
                }
            }
        }
        
        // Move the rest of the block pile down (add 10 to each block above a completed line)
        for i in 0..<blockPile.count {
            for line in completedLInes {
                if let firstPosition = line.first {
                    for n in 0..<self.game.blockPile[i].currentPosition.count {
                        if firstPosition > self.game.blockPile[i].currentPosition[n] {
                            withAnimation {
                                self.game.blockPile[i].currentPosition[n] += 10
                            }
                        }
                    }
                }
            }
        }
        
        // Increment the score/level accordingly
        if completedLInes.count == 1 {
            print("We should be incrementing the score by \(100 * level)")
            incrementScoreBy(amount: 100 * level)
            HapticsManager.shared.prepareHaptics()
            HapticsManager.shared.playHaptic(withIntensity: 0.5, andSharpness: 0.6)
        } else if completedLInes.count == 2 {
            incrementScoreBy(amount: 300 * level)
            HapticsManager.shared.prepareHaptics()
            HapticsManager.shared.playHaptic(withIntensity: 0.5, andSharpness: 0.6)
        } else if completedLInes.count == 3 {
            incrementScoreBy(amount: 500 * level)
            HapticsManager.shared.prepareHaptics()
            HapticsManager.shared.playHaptic(withIntensity: 0.6, andSharpness: 0.7)
        } else if completedLInes.count == 4 {
            incrementScoreBy(amount: 800 * level)
            HapticsManager.shared.prepareHaptics()
            HapticsManager.shared.playHaptic(withIntensity: 1, andSharpness: 1)
        }
        
        checkLevel()
    }
    
    func flipCurrentBlock() {
        guard inprogress else { return }
        switch currentBlock.blockType {
        case .straightBlock:
            if currentBlock.flipCount.isMultiple(of: 2) {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 18]
                let proposedFlip2 = [currentBlock.currentPosition[0] + 22, currentBlock.currentPosition[1] + 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 11]
                let proposedFlip3 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 27]
                let proposedFlip4 = [currentBlock.currentPosition[0] + 33, currentBlock.currentPosition[1] + 22, currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    print("Flipping on 1")
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip2) {
                    print("Flipping on 2")
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip3) {
                    print("Flipping on 3")
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip4) {
                    print("Flipping on 4")
                    game.currentShape.currentPosition = proposedFlip4
                    game.currentShape.flipCount += 1
                }
            } else {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 18]
                let proposedFlip2 = [currentBlock.currentPosition[0] - 22, currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 11]
                let proposedFlip3 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 27]
                let proposedFlip4 = [currentBlock.currentPosition[0] + 27, currentBlock.currentPosition[1] + 18, currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    print("Flipping on 1")
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip2) {
                    print("Flipping on 2")
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip3) {
                    print("Flipping on 3")
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount += 1
                } else if flipAllowed(newPosition: proposedFlip4) {
                    print("Flipping on 4")
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
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 11]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] - 9]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 11]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                }
            }
        case .lBlock:
            if currentBlock.flipCount == 0 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] - 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2] - 22, currentBlock.currentPosition[3] - 13]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 20]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 29]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] + 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 20]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 29]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
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
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount = 1
                }
            } else if currentBlock.flipCount == 1 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] + 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2] + 18, currentBlock.currentPosition[3] + 11]
                let proposedFlip3 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1] - 2, currentBlock.currentPosition[2] + 7, currentBlock.currentPosition[3]]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 2
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 2
                } else if flipAllowed(newPosition: proposedFlip3) {
                    game.currentShape.currentPosition = proposedFlip3
                    game.currentShape.flipCount = 2
                }
            } else if currentBlock.flipCount == 2 {
                let proposedFlip1 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] - 20]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 3
                }
            } else if currentBlock.flipCount == 3 {
                let proposedFlip1 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] - 2]
                let proposedFlip2 = [currentBlock.currentPosition[0], currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2] - 18, currentBlock.currentPosition[3] - 11]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                }
            }
        case .lSkewBlock:
            if currentBlock.flipCount == 0 {
                // Pivot on 2
                let proposedFlip1 = [currentBlock.currentPosition[0] + 2, currentBlock.currentPosition[1] + 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 9]
                // Pivot on 1
                let proposedFlip2 = [currentBlock.currentPosition[0] - 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 11, currentBlock.currentPosition[3] - 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                }
                else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                }
            } else if currentBlock.flipCount == 1 {
                // Pivot on 2
                let proposedFlip1 = [currentBlock.currentPosition[0] - 2, currentBlock.currentPosition[1] - 11, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 9]
                // Pivot on 1
                let proposedFlip2 = [currentBlock.currentPosition[0] + 9, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 11, currentBlock.currentPosition[3] + 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                }
            }
        case .rSkewBlock:
            if currentBlock.flipCount == 0 {
                // Pivot on 2
                let proposedFlip1 = [currentBlock.currentPosition[0] - 2, currentBlock.currentPosition[1] + 9, currentBlock.currentPosition[2], currentBlock.currentPosition[3] + 11]
                // Pivot on 1
                let proposedFlip2 = [currentBlock.currentPosition[0] - 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] - 9, currentBlock.currentPosition[3] + 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 1
                }
                else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 1
                }
            } else if currentBlock.flipCount == 1 {
                // Pivot on 2
                let proposedFlip1 = [currentBlock.currentPosition[0] + 2, currentBlock.currentPosition[1] - 9, currentBlock.currentPosition[2], currentBlock.currentPosition[3] - 11]
                // Pivot on 1
                let proposedFlip2 = [currentBlock.currentPosition[0] + 11, currentBlock.currentPosition[1], currentBlock.currentPosition[2] + 9, currentBlock.currentPosition[3] - 2]
                if flipAllowed(newPosition: proposedFlip1) {
                    game.currentShape.currentPosition = proposedFlip1
                    game.currentShape.flipCount = 0
                } else if flipAllowed(newPosition: proposedFlip2) {
                    game.currentShape.currentPosition = proposedFlip2
                    game.currentShape.flipCount = 0
                }
            }
        }
    }
    
    
    func flipAllowed(newPosition: [Int]) -> Bool {
        // Will it go through the bottom?
        for position in newPosition {
            if position > 210 {
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
            return false
        }
        
        // Will it go through the block pile?
        for block in blockPile {
            for position in newPosition {
                if block.currentPosition.contains(position) {
                    return false
                }
            }
        }
        return true
    }
}
