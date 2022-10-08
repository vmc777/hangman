//
//  hangmanTests.swift
//  hangmanTests
//
//  Created by VerDel Cargal on 9/21/22.
//

@testable import hangman
import XCTest

final class hangmanTests: XCTestCase {
    let defaultWord = "rainbow"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test4LetterWord() {
        XCTAssertThrowsError(
            try HangmanGame(word: "Mike"),
            "Hangman should not accept a 4 letter word.") { err in
                XCTAssertEqual(err as? HangmanError, HangmanError.invalidLength)
            }
    }
    
    func test8LetterWord() {
        XCTAssertThrowsError(
            try HangmanGame(word: "MikeMike"),
            "Hangman should not accept a 8 letter word.") { err in
                XCTAssertEqual(err as? HangmanError, HangmanError.invalidLength)
            }
    }
    
    func test7letterWord() throws {
        let myGame = try HangmanGame(word: defaultWord)
        XCTAssertEqual(myGame.word, "rainbow")
        XCTAssertEqual(myGame.word.count, 7)
    }
    
    func testInitialAvailableLetters() throws {
        let myGame = try HangmanGame(word: defaultWord)
        let expectedAvailableLetters = "abcdefghijklmnopqrstuvwxyz".map { $0 }
        XCTAssertEqual(myGame.availableLetters, expectedAvailableLetters)
    }
    
    func testInitialGuesses() throws {
        let myGame = try HangmanGame(word: defaultWord)
        XCTAssertEqual(myGame.incorrectGuessCount, 0)
        XCTAssertEqual(myGame.guessesRemaining, HangmanGame.INCORRECT_GUESSES_ALLOWED)
    }
    
    func testgueesesRemaingAfter3Wrong() throws {
        let myGame = try HangmanGame(word: defaultWord)
        try myGame.guessLetter("c")
        try myGame.guessLetter("d")
        try myGame.guessLetter("a")
        try myGame.guessLetter("e")
        
        let expectedAvailableLetters = "bfghijklmnopqrstuvwxyz".map { $0 }
        let expectedAnswer: [Character?] = [nil, "a", nil, nil, nil, nil, nil]

        XCTAssertEqual(myGame.availableLetters, expectedAvailableLetters)
        XCTAssertEqual(myGame.incorrectGuessCount, 3)
        XCTAssertEqual(myGame.guessesRemaining, HangmanGame.INCORRECT_GUESSES_ALLOWED - 3)
        XCTAssertEqual(myGame.answer, expectedAnswer)
        XCTAssertEqual(myGame.status, .playing)
    }

    func testLosingGame() throws {
        let myGame = try HangmanGame(word: defaultWord)
        try myGame.guessLetter("c")
        try myGame.guessLetter("d")
        try myGame.guessLetter("e")
        try myGame.guessLetter("f")
        try myGame.guessLetter("g")
        try myGame.guessLetter("h")
        XCTAssertEqual(myGame.status, .lost)
    }
    
    func testWinningGame() throws {
        let myGame = try HangmanGame(word: defaultWord)
        try myGame.guessLetter("r")
        try myGame.guessLetter("a")
        try myGame.guessLetter("i")
        try myGame.guessLetter("n")
        try myGame.guessLetter("b")
        try myGame.guessLetter("o")
        try myGame.guessLetter("w")
        XCTAssertEqual(myGame.status, HangmanGameStatus.won)
    }
    
    func testInitialGameStatus() throws {
        let myGame = try HangmanGame(word: defaultWord)
        XCTAssertEqual(myGame.status, .playing)
    }

    func testInitialAnswer() throws {
        let myGame = try HangmanGame(word: defaultWord)
        let expectedAnswer: [Character?] = [nil, nil, nil, nil, nil, nil, nil]
        XCTAssertEqual(myGame.answer, expectedAnswer)
    }

    func testDisplayableAnswer() throws {
        let myGame = try HangmanGame(word: defaultWord)
        XCTAssertEqual(myGame.displayableAnswer, "_ _ _ _ _ _ _")
        
        try myGame.guessLetter("n")
        XCTAssertEqual(myGame.displayableAnswer, "_ _ _ n _ _ _")
        
        try myGame.guessLetter("r")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ _ _")
        
        try myGame.guessLetter("w")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ _ w")
        
        try myGame.guessLetter("o")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ o w")
        
        try myGame.guessLetter("b")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n b o w")
        
        try myGame.guessLetter("i")
        XCTAssertEqual(myGame.displayableAnswer, "r _ i n b o w")
        
        try myGame.guessLetter("a")
        XCTAssertEqual(myGame.displayableAnswer, "r a i n b o w")
    }
    
    func testWordWithRepeatingLetters() throws {
        let myGame = try HangmanGame(word: "letters")
         
        try myGame.guessLetter("t")
        XCTAssertEqual(myGame.displayableAnswer, "_ _ t t _ _ _")
    }
    
    func testCantGuessAfterWinning() throws {
        let myGame = try HangmanGame(word: "letters")
        try myGame.guessLetter("l")
        try myGame.guessLetter("e")
        try myGame.guessLetter("t")
        try myGame.guessLetter("r")
        try myGame.guessLetter("s")
        XCTAssertEqual(myGame.status, .won)
        XCTAssertThrowsError(
            try myGame.guessLetter("w"),
            "Shouldn't be able to guess after winning.") { err in
                XCTAssertEqual(err as? HangmanError, HangmanError.notInPlayingStatus)
            }
    }
    
    func testCantGuessAfterLosing() throws {
        let myGame = try HangmanGame(word: "letters")
        try myGame.guessLetter("a")
        try myGame.guessLetter("b")
        try myGame.guessLetter("h")
        try myGame.guessLetter("f")
        try myGame.guessLetter("m")
        try myGame.guessLetter("n")
        XCTAssertEqual(myGame.status, .lost)
        XCTAssertThrowsError(
            try myGame.guessLetter("t"),
            "Shouldn't be able to guess after winning.") { err in
                XCTAssertEqual(err as? HangmanError, HangmanError.notInPlayingStatus)
            }
    }
    
    func testInvalidLetter() throws {
        let myGame = try HangmanGame(word: "letters")
        try myGame.guessLetter("a")
        XCTAssertThrowsError(
            try myGame.guessLetter("a"),
            "Shouldn't be able to guess a letter twice.") { err in
                XCTAssertEqual(err as? HangmanError, HangmanError.invalidLetter)
            }
    }
}
