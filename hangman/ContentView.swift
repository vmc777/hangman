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
            Group {
                Spacer()
                Text("Hangman")
                    .font(.largeTitle)
                Spacer()
            }

            Text(myGame.displayableAnswer)
                .font(.system(size: 40,weight: .heavy).monospaced())
                .foregroundColor(.indigo)
            Spacer()
            HStack(spacing: 20) {
                VStack{
                    Text("\(myGame.guessesRemaining)")
                    Text("guesses")
                    Text("remaining")
                }
                
                Gallows(guessesRemaining: myGame.guessesRemaining)
                    .stroke(.red, lineWidth: 3)
                    .frame(width: 80,height: 150)
                    
            }
  
            Spacer()
            AvailableLettersView(myGame: myGame)
            Spacer()
            Text(String(describing: myGame.status))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(hue: 0.534, saturation: 1.0, brightness: 1.0, opacity: 0.17))
        .ignoresSafeArea()

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
            VStack(spacing: 10) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(row, id: \.self) { letter in
                            Button {
                                print(letter)
                                try! myGame.guessLetter(letter)
                            } label: {
                                Image(systemName: "\(letter).square")
                                    .font(.system(size: 35))
                            }
                            .disabled(!myGame.availableLetters.contains(letter))
                        }
                       
                    }
                }
            }
            .padding()
            .disabled(myGame.status != .playing)
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
