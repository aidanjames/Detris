//
//  GridView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

struct GridView: View {
    
    @Binding var currentBlock: BlockShape
    @Binding var blockPile: [BlockShape]
    
    let columns = [
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1),
        GridItem(.fixed(SingleBrick.size), spacing: 1)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 1) {
            ForEach(1...210, id: \.self) { i in
                ZStack {
                    Rectangle()
                        .frame(height: SingleBrick.size)
                        .foregroundColor(blockColour(for: i))
                    Text("\(i)")
                        .font(.caption2)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func blockColour(for block: Int) -> Color {
        if currentBlock.currentPosition.contains(block) {
            return currentBlock.color
        }
        for blockPileBlock in blockPile {
            if blockPileBlock.currentPosition.contains(block) {
                return blockPileBlock.color
            }
        }
        return .gray
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(currentBlock: .constant(PreviewMockData.shared.currentBlock), blockPile: .constant(PreviewMockData.shared.blockPile))
    }
}


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
