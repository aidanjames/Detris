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
        if viewModel.currentBlock.currentPosition.contains(block) {
            return viewModel.currentBlock.color
        }
        for blockPileBlock in viewModel.blockPile {
            if blockPileBlock.currentPosition.contains(block) {
                return blockPileBlock.color
            }
        }
        return .gray
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(viewModel: GameViewModel())
    }
}

