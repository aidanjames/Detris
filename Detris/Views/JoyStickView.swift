//
//  JoyStickView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 13/11/2020.
//

import SwiftUI

struct JoyStickView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                Button(action: { viewModel.moveCurrentBlockLeft() } ) {
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 50, height: 50)
                        Image(systemName: "arrow.backward")
                            .font(.largeTitle)
                    }
                }
                Button(action: { viewModel.moveCurrentBlockRight() } ) {
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 50, height: 50)
                        Image(systemName: "arrow.forward")
                            .font(.largeTitle)
                    }
                }
            }
            Button(action: { viewModel.moveCurrentBlockDown() } ) {
                ZStack {
                    Circle()
                        .stroke()
                        .frame(width: 50, height: 50)
                    Image(systemName: "arrow.down")
                        .font(.largeTitle)
                }
            }
        }
    }
}

struct JoyStickView_Previews: PreviewProvider {
    static var previews: some View {
        JoyStickView(viewModel: GameViewModel())
    }
}
