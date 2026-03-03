//
//  CodeBreaker.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

// no need to create struct Peg var color
typealias Peg = Color

@Observable class CodeBreaker {
    var name: String
    var masterCode = Code(kind: .masterCode(isHidden: true))
    var guess = Code(kind: .guess)
    var attempts = [Code]()
    let pegChoices: [Peg]
    
    init(name: String = "No name assinged", pegChoices: [Peg] = [.blue, .brown, .green, .red]) {
        self.name = name
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    var isGameOver: Bool {
        if let last = attempts.last {
            return last.pegs == masterCode.pegs
        } else {
            return false
        }
    }
    
    var hasAtLeastOneGuess: Bool {
        return guess.pegs.contains { $0 != Code.missingPeg }
    }
    
    func changeGuessPeg(to peg: Peg, at index: Int) {
        guess.pegs[index] = peg
    }
    
    func undoChange(at index: Int) {
        guess.pegs[index] = Code.missingPeg
    }
    
    func attemptGuess() {
        var currentGuess = self.guess
        currentGuess.kind = .attempts(guess.match(against: masterCode))
        attempts.append(currentGuess)
        
        if isGameOver {
            masterCode.kind = .masterCode(isHidden: false)
        }
    }
    
    func resetGuess() {
        self.guess.pegs = Array(repeating: Code.missingPeg, count: 4)
    }
    
    func restart() {
        resetGuess()
        self.attempts = [Code]()
        self.masterCode = Code(kind: .masterCode(isHidden: true))
        masterCode.randomize(from: pegChoices)
    }
}

extension CodeBreaker: Identifiable, Hashable, Equatable {
    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

