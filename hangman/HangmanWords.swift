//
//  HangmanWords.swift
//  hangman
//
//  Created by VerDel Cargal on 10/19/22.
//

import Foundation

struct HangmanWords {
    private var words: [String] = ["letters", "rainbow", "charlie"]
    
    init() {
        if let fileURL = Bundle.main.url(forResource: "common-7-letter-words", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                words = fileContents.components(separatedBy: "\n")
            }
        }
    }
    
    func randomWord() -> String {
        words.randomElement()!.lowercased()
    }
}
