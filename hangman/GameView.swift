//
//  GameView.swift
//  hangman
//
//  Created by VerDel Cargal on 11/2/22.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: HangmanViewModel
    var body: some View {
        VStack {
            Spacer()
            Title()
            Spacer()
            GameState(viewModel: viewModel)
            Spacer()
            AvailableLettersView(viewModel: viewModel)
            Spacer()
            Spacer()
        }
    }
}

struct Title: View {
    var body: some View {
        Text("Hangman")
            .foregroundColor(Theme.textColor)
            .font(.largeTitle)
    }
}

struct GameState: View {
    @ObservedObject var viewModel: HangmanViewModel
    var body: some View {
        Text(viewModel.displayableAnswer)
            .font(.system(size: 40, weight: .heavy).monospaced())
            .foregroundColor(Theme.textColor)

        Spacer()

        HStack(spacing: 20) {
            RemainingGuesses(viewModel: viewModel)
            Gallows(guessesRemaining: viewModel.guessesRemaining)
                .stroke(Theme.gallowsColor, lineWidth: 3)
                .frame(width: 80, height: 150)
        }
    }
}

struct RemainingGuesses: View {
    @ObservedObject var viewModel: HangmanViewModel
    var body: some View {
        VStack {
            Text("\(viewModel.guessesRemaining)")
            Text("incorrect")
            Text("guesses")
            if viewModel.guessesRemaining == HangmanGame.INCORRECT_GUESSES_ALLOWED {
                Text("allowed")
            } else {
                Text("remaining")
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: HangmanViewModel())
    }
}
