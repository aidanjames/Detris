//
//  PreviewMockData.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import Foundation

class PreviewMockData {
    static let shared = PreviewMockData()
    
    var currentBlock: BlockShape
    var blockPile: [BlockShape]
    
    init() {
        self.currentBlock = StraightBlock()
        
        var block1 = SquareBlock()
        block1.currentPosition = [191, 192, 201, 202]
        var block2 = TBlock()
        block2.currentPosition = [205, 206, 207, 196]
        
        self.blockPile = [block1, block2]
    }
    
}
