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
            VStack {
                HStack {
                    Text("Score: \(viewModel.score)")
                    Text("Next: \(viewModel.nextBlock.blockType.rawValue)")
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
                HStack {
                    Text("Level: \(viewModel.level)")
                    Text("Interval: \(viewModel.interval)")
                }
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
