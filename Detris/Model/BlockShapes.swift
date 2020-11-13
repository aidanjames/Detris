//
//  BlockShapes.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI


enum SingleBrick {
    #warning("Determine size based on device size...")
    static let size: CGFloat = 27
}

enum BrickColor {
    static func fetchColor(for blockType: BlockType) -> Color {
        switch blockType {
        case .straightBlock:
            return .blue
        case .squareBlock:
            return .yellow
        case .tBlock:
            return .pink
        case .lBlock:
            return .red
        case .reverseLBlock:
            return .green
        }
    }
}

protocol BlockShape: Codable {
    var currentPosition: [Int] { get set }
    var blockType: BlockType { get }
    var flipCount: Int { get set}
}


enum BlockType: String, CaseIterable, Codable {
    case straightBlock
    case squareBlock
    case tBlock
    case lBlock
    case reverseLBlock
}

struct StraightBlock: BlockShape, Codable {
    var currentPosition = [14, 15, 16, 17]
    var blockType: BlockType = .straightBlock
    var flipCount: Int = 0
}

struct SquareBlock: BlockShape, Codable {
    var currentPosition = [15, 16, 25, 26]
    var blockType: BlockType = .squareBlock
    var flipCount: Int = 0
}

struct TBlock: BlockShape, Codable {
    var currentPosition = [24, 25, 26, 15]
    var blockType: BlockType = .tBlock
    var flipCount: Int = 0
}

struct LBlock: BlockShape, Codable {
    var currentPosition = [24, 25, 26, 16]
    var blockType: BlockType = .lBlock
    var flipCount: Int = 0
}

struct ReverseLBlock: BlockShape, Codable {
    var currentPosition = [24, 25, 26, 14]
    var blockType: BlockType = .reverseLBlock
    var flipCount: Int = 0    
}
