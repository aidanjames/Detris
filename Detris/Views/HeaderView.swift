//
//  HeaderView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 15/11/2020.
//

import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        if viewModel.highScore != viewModel.score {
            HStack {
                Spacer()
                VStack {
                    Text("Your score:")
                    Text("\(viewModel.score)").bold()
                }
                Spacer()
                VStack {
                    Text("High score:")
                    Text("\(viewModel.highScore)").bold()
                }
                Spacer()
            }
            .padding(.horizontal)
        } else {
            VStack {
                Text("NEW HIGH SCORE:").bold()
                Text("\(viewModel.score)").bold()
            }.foregroundColor(.red)
        }

    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: GameViewModel())
    }
}
