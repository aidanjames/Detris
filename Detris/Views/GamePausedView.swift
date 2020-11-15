//
//  GamePausedView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 15/11/2020.
//

import SwiftUI

struct GamePausedView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        ZStack {
            Color.white.cornerRadius(16)
            VStack(spacing: 5) {
                Text("GAME PAUSED").font(.largeTitle).foregroundColor(.black)
                Text("Ready when you are...").foregroundColor(.black)
                Button(action: { viewModel.resumeGame() }) {
                    Text("Let's get back at it!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}

struct GamePausedView_Previews: PreviewProvider {
    static var previews: some View {
        GamePausedView(viewModel: GameViewModel())
    }
}
