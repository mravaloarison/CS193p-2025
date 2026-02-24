//
//  CodeBreaker.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

// no need to create struct Peg var color
typealias Peg = Color

struct CodeBreaker {
    var masterCode = Code(kind: .masterCode(isHidden: true))
    var guess = Code(kind: .guess)
    var attempts = [Code]()
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.blue, .brown, .green, .red]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        
        print(masterCode.pegs)
    }
    
    var isGameOver: Bool {
        attempts.last?.pegs == masterCode.pegs
    }
    
    mutating func changeGuessPeg(to peg: Peg, at index: Int) {
        guess.pegs[index] = peg
    }
    
    mutating func attemptGuess() {
        var currentGuess = self.guess
        currentGuess.kind = .attempts(guess.match(against: masterCode))
        attempts.append(currentGuess)
        
        if isGameOver {
            masterCode.kind = .masterCode(isHidden: false)
        }
    }
    
    mutating func resetGuess() {
        self.guess.pegs = Array(repeating: Code.missingPeg, count: 4)
    }
}
