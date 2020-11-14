//
//  ReverseLBlockPreview.swift
//  Detris
//
//  Created by Aidan Pendlebury on 14/11/2020.
//

import SwiftUI

struct ReverseLBlockPreview: View {
    let brickSize = SingleBrick.size / 2
    
    var body: some View {
        VStack(spacing: 1) {
            HStack(spacing: 1) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                    .opacity(0)
            }
            HStack(spacing: 1) {
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
                Rectangle()
                    .frame(width: brickSize, height: brickSize)
            }
        }
        .foregroundColor(BrickColor.fetchColor(for: .reverseLBlock))
    }
}

struct ReverseLBlockPreview_Previews: PreviewProvider {
    static var previews: some View {
        ReverseLBlockPreview()
    }
}
