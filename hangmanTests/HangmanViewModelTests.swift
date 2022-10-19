//
//  HangmanViewModelTests.swift
//  hangmanTests
//
//  Created by VerDel Cargal on 10/19/22.
//

@testable import hangman
import XCTest

final class HangmanViewModelTests: XCTestCase {
    let defaultWord = "rainbow"
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialAvailableLetters() {
        let myGame = HangmanViewModel(word: defaultWord)
        let expectedAvailableLetters = "abcdefghijklmnopqrstuvwxyz".map { $0 }
        XCTAssertEqual(myGame.availableLetters, expectedAvailableLetters)
    }
    
    func testDisplayableAnswer() throws {
        let myGame = HangmanViewModel(word: defaultWord)
        XCTAssertEqual(myGame.displayableAnswer, "_ _ _ _ _ _ _")
        
        myGame.guessLetter("n")
        XCTAssertEqual(myGame.displayableAnswer, "_ _ _ n _ _ _")
        
        myGame.guessLetter("r")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ _ _")
        
        myGame.guessLetter("w")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ _ w")
        
        myGame.guessLetter("o")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n _ o w")
        
        myGame.guessLetter("b")
        XCTAssertEqual(myGame.displayableAnswer, "r _ _ n b o w")
        
        myGame.guessLetter("i")
        XCTAssertEqual(myGame.displayableAnswer, "r _ i n b o w")
        
        myGame.guessLetter("a")
        XCTAssertEqual(myGame.displayableAnswer, "r a i n b o w")
    }

    func testInitialGuesses() throws {
        let myGame = HangmanViewModel(word: defaultWord)
        XCTAssertEqual(myGame.guessesRemaining, HangmanGame.INCORRECT_GUESSES_ALLOWED)
    }

    func testgueesesRemaingAfter3Wrong() throws {
        let myGame = HangmanViewModel(word: defaultWord)
        myGame.guessLetter("c")
        myGame.guessLetter("d")
        myGame.guessLetter("a")
        myGame.guessLetter("e")
        
        XCTAssertEqual(myGame.guessesRemaining, HangmanGame.INCORRECT_GUESSES_ALLOWED - 3)
    }
    
    func testIfAvailableLettersUpdated() throws {
        let myGame = HangmanViewModel(word: defaultWord)
        myGame.guessLetter("d")
        let expectedAvailableLetters = "abcefghijklmnopqrstuvwxyz".map { $0 }
        XCTAssertEqual(myGame.availableLetters, expectedAvailableLetters)
    }
}
