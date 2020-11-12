//
//  GameView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    
    var body: some View {
        VStack {
            Text("This")
            GridView(viewModel: viewModel)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
