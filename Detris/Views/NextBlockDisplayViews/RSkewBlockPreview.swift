//
//  RSkewBlockPreview.swift
//  Detris
//
//  Created by Aidan Pendlebury on 14/11/2020.
//

import SwiftUI

struct RSkewBlockPreview: View {
    let brickSize = SingleBrick.size / 2
    
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 1) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
            }
            HStack(spacing: 1) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
            }
        }
        .foregroundColor(BrickColor.fetchColor(for: .rSkewBlock))
    }
}

struct RSkewBlockPreview_Previews: PreviewProvider {
    static var previews: some View {
        RSkewBlockPreview()
    }
}
