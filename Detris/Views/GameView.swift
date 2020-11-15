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
        GeometryReader { geo in
            ZStack {
                VStack {
                       HeaderView(viewModel: viewModel)
                    HStack {
                        Spacer()
                        GridView(viewModel: viewModel)
                        RightSideView(viewModel: viewModel)
                            .padding(.horizontal, 8)
                    }
                    HStack(alignment: .top) {
                        JoyStickView(viewModel: viewModel)
                        Spacer()
                        FlipButtonView(viewModel: viewModel)
                            .frame(width: 80, height: 80)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top)
                }
                
                Color.black.ignoresSafeArea().opacity(viewModel.gameOver || viewModel.gamePaused ? 0.4 : 0)
                if viewModel.gameOver {
                    GameOverView(viewModel: viewModel)
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.4)
                }
                if viewModel.gamePaused && !viewModel.gameOver {
                    GamePausedView(viewModel: viewModel)
                        .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.4)
                }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
