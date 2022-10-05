//
//  ContentView.swift
//  hangman
//
//  Created by VerDel Cargal on 9/21/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var myGame = try! HangmanGame(word: "letters")


    var body: some View {
        VStack {
            Text("Hangman")
            Spacer()
            HStack {
                Text(myGame.displayableAnswer)
                Spacer()
                Text("\(myGame.guessesRemaining) guesses remaining")
            }.padding()
            Spacer()
            AvailableLettersView(myGame: myGame)
            Spacer()
            Text(String(describing: myGame.status))
            Spacer()
        }
    }

    struct AvailableLettersView: View {
        @ObservedObject var myGame: HangmanGame

        let rows: [[Character]] = [
            ["a", "b", "c", "d", "e", "f", "g"],
            ["h", "i", "j", "k", "l", "m"],
            ["n", "o", "p", "q", "r", "s", "t"],
            ["u", "v", "w", "x", "y", "z"]
        ]

        var body: some View {
            VStack {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 31.0) {
                        ForEach(row, id: \.self) { letter in
                            Button(String(letter)) {
                                print(letter)
                                try! myGame.guessLetter(letter)
                            }
                        }
                    }
                    .padding()
                }
            }
            .padding(30)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

//            .frame(maxWidth: .infinty, maxHeight: .infinity)
//            Text ("how many games you've won")
//            Text("letters available", \(myGame.usedLetters.debugDescription))
//        }
//        .padding()
