//
//  GridView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

struct GridView: View {
    
    @ObservedObject var viewModel: GameViewModel
    
    let columns = [
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5),
        GridItem(.fixed(SingleBrick.size), spacing: 0.5)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0.5) {
            ForEach(1...210, id: \.self) { i in
                ZStack {
                    Rectangle()
                        .frame(width: SingleBrick.size, height: SingleBrick.size)
                        .foregroundColor(blockColour(for: i))
//                    #warning("Get rid of this")
//                    Text("\(i)")
//                        .font(.caption2)
//                        .foregroundColor(.white)
                }
            }
        }
    }
    
    func blockColour(for block: Int) -> Color {
        if viewModel.currentBlock.currentPosition.contains(block) {
            return BrickColor.fetchColor(for: viewModel.currentBlock.blockType)
        }
        for blockPileBlock in viewModel.blockPile {
            if blockPileBlock.currentPosition.contains(block) {
                return BrickColor.fetchColor(for: blockPileBlock.blockType)
                
            }
        }
        return Color.secondary.opacity(0.2)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(viewModel: GameViewModel())
    }
}

