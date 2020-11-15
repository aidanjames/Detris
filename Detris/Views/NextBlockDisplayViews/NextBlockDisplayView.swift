//
//  NextBlockDisplayView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 14/11/2020.
//

import SwiftUI

struct NextBlockDisplayView: View {
    var nextBlockShape: BlockType
    
    var body: some View {
        HStack {
            Text("Next:")
            switch nextBlockShape {
            case .straightBlock:
                StraightBlockPreview()
            case .squareBlock:
                SquareBlockPreview()
            case .tBlock:
                TBlockPreview()
            case .lBlock:
                LBlockPreview()
            case .reverseLBlock:
                ReverseLBlockPreview()
            case .lSkewBlock:
                LSkewBlockPreview()
            case .rSkewBlock:
                RSkewBlockPreview()
            }
        }
        .frame(height: SingleBrick.size)
    }
}

struct NextBlockDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NextBlockDisplayView(nextBlockShape: Game.generateRandomBlockShape().blockType)
    }
}
