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
                }
            }
        }
        .gesture(
                DragGesture(minimumDistance: 50)
                    .onChanged { value in
                        if value.predictedEndTranslation.height > 300 {
                            viewModel.moveCurrentBlockDown()
                            viewModel.moveCurrentBlockDown()
                        } else {
                            if value.predictedEndTranslation.width < -200 {
                                viewModel.moveCurrentBlockLeft()
                            } else if value.predictedEndTranslation.width < 0 && Int(value.predictedEndTranslation.width) % 10 == 0 {
                                viewModel.moveCurrentBlockLeft()
                            }
                            
                            if value.predictedEndTranslation.width > 100 {
                                viewModel.moveCurrentBlockRight()
                            } else if value.predictedEndTranslation.width > 0 && Int(value.predictedEndTranslation.width) % 10 == 0 {
                                viewModel.moveCurrentBlockRight()
                            }
                        }
                        
                        
                        
                        
//                        if value.location.y * 0.6 > value.startLocation.y {
//                            print("I've been moved down?")
//                            viewModel.moveCurrentBlockDown()
//                        } else {
//                            if value.location.x * 0.7 < value.startLocation.x {
//    //                            print("I've been dragged to the left...")
//                                viewModel.moveCurrentBlockLeft()
//                            }
//                            if value.location.x * 0.7 > value.startLocation.x {
//    //                            print("I've been dragged to the right...")
//                                viewModel.moveCurrentBlockRight()
//                            }
//                        }
//                        if value.translation.width < -80 {
//                            viewModel.moveCurrentBlockLeft()
//                        }
//
                        
                    }
                    .onEnded { value in
//                        print("Dragged! \(value.translation)")
                        print(value.translation)
//                        if value.translation.width < -80 {
//                            viewModel.moveCurrentBlockLeft()
//                        }
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
