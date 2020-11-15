//
//  RightSideView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 15/11/2020.
//

import SwiftUI

struct RightSideView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            
            VStack(spacing: 15) {
                Text("Up next:").font(.caption)
                NextBlockDisplayView(nextBlockShape: viewModel.nextBlock.blockType)
            }
            .padding(.vertical)
            
            VStack(spacing: 5) {
                Text("Lines:").font(.caption)
                Text("\(viewModel.lines)")
            }
            VStack(spacing: 5) {
                Text("Level:").font(.caption)
                Text("\(viewModel.level)")
            }
            Button(action: { viewModel.pauseGame() } ) {
                Image(systemName: "pause.circle")
                    .font(.largeTitle)
            }
            .disabled(!viewModel.inprogress)
            .padding(.bottom)
        }
        .padding(.vertical)
        .padding(.horizontal, 2)
        .background(Color.secondary.opacity(0.2))
        .cornerRadius(16)
    }
}

struct RightSideView_Previews: PreviewProvider {
    static var previews: some View {
        RightSideView(viewModel: GameViewModel())
    }
}
