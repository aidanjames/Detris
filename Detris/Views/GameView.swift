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
            HStack {
                Text("Score: \(viewModel.score)")
                Text("Next: \(viewModel.nextBlock.blockType.rawValue)")
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
