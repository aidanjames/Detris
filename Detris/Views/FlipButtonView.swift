//
//  FlipButtonView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 13/11/2020.
//

import SwiftUI

struct FlipButtonView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        Button(action: { viewModel.flipCurrentBlock() } ) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                Text("Flip")
                    .foregroundColor(.white)
            }
        }
    }
}

struct FlipButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FlipButtonView(viewModel: GameViewModel())
    }
}
