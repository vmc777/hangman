//
//  LostView.swift
//  hangman
//
//  Created by VerDel Cargal on 11/2/22.
//

import SwiftUI

struct LostView: View {
    @ObservedObject var viewModel: HangmanViewModel
    let cornerRadius = 30.0
    var body: some View {
        VStack {
            Spacer()
            Text("You Lost!")
                .foregroundColor(.red)
                .font(.system(size: 30, weight: .heavy))
            Text("The word was \"\(viewModel.word)\".")
            Text("Wow, that word was hard. Let's try again!")
            Spacer()
            Button("OK") { viewModel.startNewGame() }
            Spacer()
        }
        .frame(width: 300, height: 200)
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
    }
}

struct LostView_Previews: PreviewProvider {
    static var previews: some View {
        LostView(viewModel: HangmanViewModel())
    }
}
