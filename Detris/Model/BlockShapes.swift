//
//  BlockShapes.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI


enum SingleBrick {
    static let size: CGFloat = 25
}

protocol BlockShape {
    var currentPosition: [Int] { get set }
    var color: Color { get }
    var blockType: BlockType { get }
    var flipCount: Int { get set}
}

enum BlockType: CaseIterable {
    case straightBlock
    case squareBlock
    case tBlock
    case lBlock
    case reverseLBlock
}

struct StraightBlock: BlockShape {
    var currentPosition = [14, 15, 16, 17]
    var color: Color = .blue
    var blockType: BlockType = .straightBlock
    var flipCount: Int = 0
}

struct SquareBlock: BlockShape {
    var currentPosition = [15, 16, 25, 26]
    var color: Color = .yellow
    var blockType: BlockType = .squareBlock
    var flipCount: Int = 0
}

struct TBlock: BlockShape {
    var currentPosition = [24, 25, 26, 15]
    var color: Color = .pink
    var blockType: BlockType = .tBlock
    var flipCount: Int = 0
}

struct LBlock: BlockShape {
    var currentPosition = [24, 25, 26, 16]
    var color: Color = .green
    var blockType: BlockType = .lBlock
    var flipCount: Int = 0
}

struct ReverseLBlock: BlockShape {
    var currentPosition = [24, 25, 26, 14]
    var color: Color = .red
    var blockType: BlockType = .reverseLBlock
    var flipCount: Int = 0
}
