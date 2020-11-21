//
//  SwipeableGridView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 17/11/2020.
//

import SwiftUI

struct SwipeableGridView: View {
    
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
                    //                    Text("\(i)").font(.caption)
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onChanged { value in
                    if value.predictedEndTranslation.height > 180 && Int(value.predictedEndTranslation.height) % 10 == 0 {
                        print("Slow move down...")
                        viewModel.moveCurrentBlockDown()
                    } else if value.predictedEndTranslation.height >= 300 {
                        print("Fast move down...")
                        viewModel.moveCurrentBlockDown()
                    } else {
                        if value.predictedEndTranslation.width < -50 && abs(Int(value.predictedEndTranslation.width)) % 10 == 0 {
                            viewModel.moveCurrentBlockLeft()
                        }
                        if value.predictedEndTranslation.width > 50 && abs(Int(value.predictedEndTranslation.width)) % 10 == 0 {
                            viewModel.moveCurrentBlockRight()
                        }
                    }
                }
                .onEnded { value in
                }
        )
        .onTapGesture {
            viewModel.flipCurrentBlock()
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

struct SwipeableGridView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeableGridView(viewModel: GameViewModel())
    }
}
