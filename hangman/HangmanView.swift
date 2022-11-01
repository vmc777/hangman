//
//  HangmanView.swift (ContentView.swift)
//  hangman (app name)
//
//  Created by VerDel Cargal on 9/21/22.
//

import SwiftUI

let backgroundColor = Color(red: 255/255, green: 209/255, blue: 102/255)
let gallowsColor = Color(red: 239/255, green: 71/255, blue: 111/255)
let textColor = Color(red: 7/255, green: 59/255, blue: 76/255)
let popupBackgroundColor = Color(red: 6/255, green: 214/255, blue: 160/255)
let popupBorderColor = Color(red: 17/255, green: 138/255, blue: 178/255)
let popupTextColor = gallowsColor
let keyboardColor = textColor

struct HangmanView: View {
    @StateObject var viewModel = HangmanViewModel()

    var body: some View {
        ZStack {
            GameView(viewModel: viewModel)
            if viewModel.status == .won {
                WonView(viewModel: viewModel)
            }
            if viewModel.status == .lost {
                LostView(viewModel: viewModel)
            }
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .ignoresSafeArea()
    }

    struct GameView: View {
        @ObservedObject var viewModel: HangmanViewModel
        var body: some View {
            VStack {
                Group {
                    Spacer()
                    Text("Hangman")
                        .font(.largeTitle)
                    Spacer()
                }

                Text(viewModel.displayableAnswer)
                    .font(.system(size: 40, weight: .heavy).monospaced())
                    .foregroundColor(textColor)
                Spacer()
                HStack(spacing: 20) {
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

                    Gallows(guessesRemaining: viewModel.guessesRemaining)
                        .stroke(gallowsColor, lineWidth: 3)
                        .frame(width: 80, height: 150)
                }

                Spacer()
                AvailableLettersView(viewModel: viewModel)
                Spacer()

                Spacer()
            }
        }
    }

    struct AvailableLettersView: View {
        @ObservedObject var viewModel: HangmanViewModel

        let rows: [[Character]] = [
            ["a", "b", "c", "d", "e", "f", "g"],
            ["h", "i", "j", "k", "l", "m"],
            ["n", "o", "p", "q", "r", "s", "t"],
            ["u", "v", "w", "x", "y", "z"]
        ]

        var body: some View {
            VStack(spacing: 10) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { letter in
                            Button {
                                viewModel.guessLetter(letter)

                            } label: {
                                Image(systemName: "\(letter).square")
                                    .font(.system(size: 35))
                            }
                            .disabled(!viewModel.availableLetters.contains(letter))
                        }
                    }
                }
            }
            .padding()
//            .foregroundColor(keyboardColor)
            .disabled(viewModel.status != .playing)
        }
    }

    struct WonView: View {
        @ObservedObject var viewModel: HangmanViewModel
        @State var fontSize = 10.0

        let cornerRadius = 30.0
        var body: some View {
            VStack {
                Spacer()
                Text("You Won!")
                    .foregroundColor(popupTextColor)
                    .font(.system(size: fontSize, weight: .heavy))
                Spacer()
                Button("OK") { viewModel.startNewGame() }
                Spacer()
            }
            .frame(width: 300, height: 150)
            .foregroundColor(popupBorderColor)
            .background(
                RoundedRectangle(
                    cornerRadius: cornerRadius)
                    .fill(popupBackgroundColor))
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius)
                    .stroke(popupBorderColor, lineWidth: 5)
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

    struct LostView: View {
        @ObservedObject var viewModel: HangmanViewModel
        let cornerRadius = 30.0
        var body: some View {
            VStack {
                Spacer()
                Text("You Lost!")
                    .foregroundColor(.red)
                    .font(.system(size: 30, weight: .heavy))
                Text("The word was \"\(viewModel.word)\"")
                Spacer()
                Button("OK") { viewModel.startNewGame() }
                Spacer()
            }
            .frame(width: 300, height: 200)
            .foregroundColor(popupBorderColor)
            .background(
                RoundedRectangle(
                    cornerRadius: cornerRadius)
                    .fill(popupBackgroundColor))
            .overlay(
                RoundedRectangle(
                    cornerRadius: cornerRadius)
                    .stroke(popupBorderColor, lineWidth: 5)
            )
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HangmanView()
        }
    }
}
