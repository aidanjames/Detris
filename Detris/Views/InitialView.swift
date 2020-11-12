//
//  InitialView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 12/11/2020.
//

import SwiftUI

struct InitialView: View {
    @State private var showingGameView = false
    
    var body: some View {
        VStack {
            Text("Detris")
            Button("Start new game") {
                showingGameView = true
            }
            .fullScreenCover(isPresented: $showingGameView) {
                GameView()
            }
        }
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
