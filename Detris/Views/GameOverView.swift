//
//  GameOverView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 15/11/2020.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.white.cornerRadius(16)
            VStack(spacing: 5) {
                Text("GAME OVER").font(.largeTitle).foregroundColor(.black)
                Text("Sorry, that's game over ☹️").foregroundColor(.black)
                Text("You scored \(viewModel.score) points!").foregroundColor(.black)
                Text("Have another go?").padding(.top).foregroundColor(.black)
                Button(action: { viewModel.startGame() }) {
                    Text("Again again again!")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(16)
                }
                .padding()
                Button(action: {
                    viewModel.gameOver = false
                    presentationMode.wrappedValue.dismiss()
                } ) {
                    Text("Nah, I'm good.").foregroundColor(.blue)
                }
            }
        }
    }
}

struct GameOverVieqw_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(viewModel: GameViewModel())
    }
}
