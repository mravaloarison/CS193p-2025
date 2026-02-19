//
//  MatchMakers.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

enum Match {
    case correctPosition
    case wrongPosition
    case notInTheCode
}

struct MatchMakers: View {
    var matches: [Match]
    
    var body: some View {
        HStack {
            VStack {
                matchMaker(peg: 0)
                matchMaker(peg: 1)
            }
            
            VStack {
                matchMaker(peg: 2)
                matchMaker(peg: 3)
            }
        }
        .padding()
    }

    func matchMaker(peg: Int) -> some View {
        let correctPositionCounted = matches.count { $0 == .correctPosition }
        let wrongPositionCounted = matches.count { $0 != .notInTheCode }
        
        return Circle()
            .fill(correctPositionCounted > peg ? Color.primary : Color.clear)
            .strokeBorder(wrongPositionCounted > peg ? Color.primary : Color.clear)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    MatchMakers(matches: [.correctPosition, .notInTheCode, .correctPosition, .wrongPosition])
}
