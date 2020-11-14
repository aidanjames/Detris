//
//  GameView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            if !viewModel.gameOver {
                VStack {
                    HStack {
                        Text("Score: \(viewModel.score)")
                        NextBlockDisplayView(nextBlockShape: viewModel.nextBlock.blockType)
                    }
                    HStack {
                        Text("Level: \(viewModel.level)")
                        Button(action: {
                            if viewModel.inprogress {
                                viewModel.pauseGame()
                            } else {
                                viewModel.startGame()
                            }
                        } ) {
                            Image(systemName: viewModel.inprogress ? "pause.circle.fill" : "play.circle.fill")
                        }
                        Button(action: { viewModel.incrementLevel() } ) {
                            Image(systemName: "plus.circle.fill")
                        }
                    }
                }
            } else {
                Text("GAME OVER").font(.largeTitle)
            }
            GridView(viewModel: viewModel)
            HStack(alignment: .top) {
                JoyStickView(viewModel: viewModel)
                Spacer()
                FlipButtonView(viewModel: viewModel)
                    .frame(width: 80, height: 80)
            }
            .padding(.horizontal, 20)
            .padding(.top)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
