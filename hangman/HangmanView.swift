//
//  HangmanView.swift (ContentView.swift)
//  hangman (app name)
//
//  Created by VerDel Cargal on 9/21/22.
//

import SwiftUI

struct HangmanView: View {
    @StateObject var viewModel = HangmanViewModel()
    @State private var showingAlert = false

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
                .foregroundColor(.indigo)
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
                    .stroke(.red, lineWidth: 3)
                    .frame(width: 80, height: 150)
            }

            Spacer()
            AvailableLettersView(viewModel: viewModel) {
                showingAlert = $0
            }
            Spacer()

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(hue: 0.534, saturation: 1.0, brightness: 1.0, opacity: 0.17))
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(viewModel.status == .lost ? "You Lost" : "You Won!!"),
                message: Text(viewModel.status == .lost ? "The word was \"\(viewModel.word)\"." : ""),
                dismissButton: .cancel(Text("OK")) {
                    viewModel.startNewGame()
                })
        }
        .ignoresSafeArea()
    }

    struct AvailableLettersView: View {
        @ObservedObject var viewModel: HangmanViewModel
        let updateShowingAlert: (Bool) -> Void

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
                                updateShowingAlert(viewModel.status != .playing)
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
            .disabled(viewModel.status != .playing)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HangmanView()
        }
    }
}
