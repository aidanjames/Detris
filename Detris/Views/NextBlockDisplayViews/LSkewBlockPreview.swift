//
//  LSkewBlockPreview.swift
//  Detris
//
//  Created by Aidan Pendlebury on 14/11/2020.
//

import SwiftUI

struct LSkewBlockPreview: View {
    let brickSize = SingleBrick.size / 2
    
    var body: some View {
        HStack(spacing: 0.5) {
            VStack(spacing: 0.5) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
            }
            VStack(spacing: 0.5) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
            }
            
        }
        .foregroundColor(BrickColor.fetchColor(for: .lSkewBlock))
    }
}

struct LSkewBlockPreview_Previews: PreviewProvider {
    static var previews: some View {
        LSkewBlockPreview()
    }
}
