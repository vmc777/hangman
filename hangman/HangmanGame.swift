//
//  HangmanGame.swift
//  HangmanCommandLine
//
//  Created by VerDel Cargal on 9/21/22.
//

import Foundation

enum HangmanError: Error {
    case invalidLength
    case invalidLetter
    case notInPlayingStatus
    case _dummy_test_err
}

enum HangmanGameStatus {
    case playing
    case won
    case lost
}

struct HangmanGame {
    static let LETTER_COUNT = 7
    static let INCORRECT_GUESSES_ALLOWED = 6

    let word: String
    private(set) var availableLetters: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    private(set) var incorrectGuessCount = 0

    var answer: [Character?] {
        word.map { availableLetters.contains($0.lowercased()) ? nil : $0 }
    }

    var status: HangmanGameStatus {
        if answer.allSatisfy({ $0 != nil }) {
            return .won
        }
        if incorrectGuessCount >= HangmanGame.INCORRECT_GUESSES_ALLOWED {
            return .lost
        }
        return .playing
    }

    init(word: String) throws {
        if word.count != HangmanGame.LETTER_COUNT {
            print("Creating Hangman game using word: \"\(word)\"")
            throw HangmanError.invalidLength
        }
        self.word = word
    }

    mutating func guessLetter(_ letter: Character) throws {
        if status != .playing {
            throw HangmanError.notInPlayingStatus
        }
        if !availableLetters.contains(letter) {
            throw HangmanError.invalidLetter
        }

        availableLetters.removeAll { $0 == letter }
        if !word.contains(letter) {
            incorrectGuessCount += 1
        }
    }
}
