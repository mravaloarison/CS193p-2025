//
//  Code.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/24/26.
//


import SwiftUI

struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4)
    
    static var missingPeg: Peg = .clear
    
    enum Kind: Equatable {
        case masterCode(isHidden: Bool)
        case guess
        case attempts([Match])
    }
    
    var isHidden: Bool {
        switch kind {
        case .masterCode(let isHidden): return isHidden
        default: return false
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempts(let matches): return matches
        default: return []
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
        print(pegs)
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
