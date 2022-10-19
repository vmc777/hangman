//
//  hangmanViewModel.swift
//  hangman
//
//  Created by VerDel Cargal on 10/19/22.
//

import Foundation

class HangmanViewModel: ObservableObject {
    private var game: HangmanGame
    
    @Published private(set) var availableLetters: [Character]
    
    convenience init() {
        // stub
        let words = ["letters", "rainbow", "charlie"]
        // -- stub
        self.init(word: words.randomElement()!)
    }
    
    required init(word: String) {
        game = try! HangmanGame(word: word)
        availableLetters = game.availableLetters
    }
    
    var displayableAnswer: String {
        let answer = game.answer
        return "\(answer[0] ?? "_") \(answer[1] ?? "_") \(answer[2] ?? "_") \(answer[3] ?? "_") \(answer[4] ?? "_") \(answer[5] ?? "_") \(answer[6] ?? "_")"
    }
    
    var guessesRemaining: Int {
        HangmanGame.INCORRECT_GUESSES_ALLOWED - game.incorrectGuessCount
    }
    
    var status: HangmanGameStatus {
        game.status
    }
    
    func guessLetter(_ letter: Character) {
        try! game.guessLetter(letter)
        availableLetters = game.availableLetters
    }
    
    func startNewGame() {
        // TODO: Unit Test (??)
        let words = ["letters", "rainbow", "charlie"]
        game = try! HangmanGame(word: words.randomElement()!)
        availableLetters = game.availableLetters
    }
}
