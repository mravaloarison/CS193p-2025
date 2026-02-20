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
    var masterCode = Code(kind: .masterCode)
    var guess = Code(kind: .guess)
    var attempts = [Code]()
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.blue, .brown, .green, .red]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfcurrentPeg = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfcurrentPeg + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
    mutating func attemptGuess() {
        var currentGuess = self.guess
        currentGuess.kind = .attempts(guess.match(against: masterCode))
        attempts.append(currentGuess)
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static var missing: Peg = .clear
    
    enum Kind: Equatable {
        case masterCode
        case guess
        case attempts([Match])
    }
    
    var matches: [Match] {
        switch kind {
        case .attempts(let matches): return matches
        default: return []
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var results: [Match] = Array(repeating: .notInTheCode, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                results[index] = .correctPosition
                pegsToMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if results[index] != .correctPosition {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    results[index] = .wrongPosition
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        
        return results
    }
}
