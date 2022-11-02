//
//  AvailableLettersView.swift
//  hangman
//
//  Created by VerDel Cargal on 11/2/22.
//

import SwiftUI

struct AvailableLettersView: View {
    @ObservedObject var viewModel: HangmanViewModel

//    init(viewModel: HangmanViewModel) {
//        self.viewModel = viewModel
//    }
    
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
        .accentColor(Theme.textColor)
        .padding()
        .disabled(viewModel.status != .playing)
    }
}


struct AvailableLettersView_Previews: PreviewProvider {
    static var previews: some View {
        AvailableLettersView(viewModel: HangmanViewModel())
    }
}
