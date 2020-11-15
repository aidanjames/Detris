//
//  JoyStickView.swift
//  Detris
//
//  Created by Aidan Pendlebury on 13/11/2020.
//

import SwiftUI

struct JoyStickView: View {
    @ObservedObject var viewModel: GameViewModel
    
    @State private var downTimer: Timer?
    @State private var downIsLongPressed = false
    
    @State private var leftTimer: Timer?
    @State private var leftIsLongPressing = false
    
    @State private var rightTimer: Timer?
    @State private var rightIsLongPressing = false
    
    let minimumDuration: Double = 0.15
    let timeInterval: Double = 0.05
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                Button(action: {
                    if leftIsLongPressing {
                        leftIsLongPressing = false
                        leftTimer?.invalidate()
                        rightTimer?.invalidate()
                        downTimer?.invalidate()
                    } else {
                        viewModel.moveCurrentBlockLeft()
                    }
                } ) {
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 50, height: 50)
                        Image(systemName: "arrow.backward")
                            .font(.largeTitle)
                    }
                }
                .disabled(!viewModel.inprogress)
                .simultaneousGesture(LongPressGesture(minimumDuration: minimumDuration).onEnded { _ in
                    leftIsLongPressing = true
                    rightIsLongPressing = false
                    // There appears to be a bug where you long press the left button it triggers the right button long press, so I have to invalidate the right timer as a workaround.
                    rightTimer?.invalidate()
                    downTimer?.invalidate()
                    leftTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
                        if leftIsLongPressing {
                            viewModel.moveCurrentBlockLeft()
                        }
                    })
                })
                Button(action: {
                    if rightIsLongPressing {
                        rightIsLongPressing = false
                        rightTimer?.invalidate()
                        leftTimer?.invalidate()
                        downTimer?.invalidate()
                    } else {
                        viewModel.moveCurrentBlockRight()
                    }
                } ) {
                    ZStack {
                        Circle()
                            .stroke()
                            .frame(width: 50, height: 50)
                        Image(systemName: "arrow.forward")
                            .font(.largeTitle)
                    }
                }
            }
            .disabled(!viewModel.inprogress)
            .simultaneousGesture(LongPressGesture(minimumDuration: minimumDuration).onEnded { _ in
                rightIsLongPressing = true
                leftIsLongPressing = false
                leftTimer?.invalidate()
                downTimer?.invalidate()
                rightTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
                    if rightIsLongPressing {
                        viewModel.moveCurrentBlockRight()
                    }
                })
            })
            Button(action: {
                if downIsLongPressed {
                    downIsLongPressed = false
                    downTimer?.invalidate()
                    leftTimer?.invalidate()
                    rightTimer?.invalidate()
                } else {
                    viewModel.moveDownButtonPressed()
                }
            } ) {
                ZStack {
                    Circle()
                        .stroke()
                        .frame(width: 50, height: 50)
                    Image(systemName: "arrow.down")
                        .font(.largeTitle)
                }
            }
            .disabled(!viewModel.inprogress)
            .simultaneousGesture(LongPressGesture(minimumDuration: minimumDuration).onEnded { _ in
                self.downIsLongPressed = true
                leftTimer?.invalidate()
                rightTimer?.invalidate()
                self.downTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { _ in
                    viewModel.moveDownButtonPressed()
                })
            })
        }
        .onChange(of: viewModel.blockPile.count, perform: { _ in
            downTimer?.invalidate()
            downIsLongPressed = false
            leftTimer?.invalidate()
            leftIsLongPressing = false
            rightTimer?.invalidate()
            rightIsLongPressing = false
            
        })
    }
}

struct JoyStickView_Previews: PreviewProvider {
    static var previews: some View {
        JoyStickView(viewModel: GameViewModel())
    }
}
