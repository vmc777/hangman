//
//  WonView.swift
//  hangman
//
//  Created by VerDel Cargal on 11/2/22.
//

import SwiftUI

struct WonView: View {
    @ObservedObject var viewModel: HangmanViewModel
    @State var fontSize = 10.0

    let cornerRadius = 30.0
    var body: some View {
        VStack {
            Spacer()
            Text("You Won!")
                .foregroundColor(Theme.popupTextColor)
                .font(.system(size: fontSize, weight: .heavy))
            Text("Great job! Let's do another!")
//            Text("You have won \() times")
            Spacer()
            Button("OK") { viewModel.startNewGame() }
            Spacer()
        }
        .frame(width: 300, height: 150)
        .foregroundColor(Theme.popupBorderColor)
        .background(
            RoundedRectangle(
                cornerRadius: cornerRadius)
            .fill(Theme.popupBackgroundColor))
        .overlay(
            RoundedRectangle(
                cornerRadius: cornerRadius)
            .stroke(Theme.popupBorderColor, lineWidth: 5)
        )
        .onAppear {
            withAnimation(.spring(
                response: 0.8,
                dampingFraction: 0.2,
                blendDuration: 5)
            ) {
                fontSize = 30
            }
        }
    }
}

struct WonView_Previews: PreviewProvider {
    static var previews: some View {
        WonView(viewModel: HangmanViewModel())
    }
}
