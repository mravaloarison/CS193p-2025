//
//  CodeBreakerView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

struct CodeBreakerView: View {
    @State private var game = CodeBreaker(pegChoices: [.indigo, .pink, .purple, .blue])
    @State private var selection: Int = 0
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                if !game.isGameOver {
                    view(for: game.guess)
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view (for: game.attempts[index])
                }
            }
            Spacer()
            
            PegChooser(choices: game.pegChoices, isGameOver: game.isGameOver) { peg in
                game.changeGuessPeg(to: peg, at: selection)
                selection = (selection + 1) % game.pegChoices.count
            }
        }
        .padding()
    }
    
    var attemptButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
            game.resetGuess()
            selection = 0
        }
    }
    
    func view(for code: Code) -> some View {
        HStack {
            PegsView(code: code, selection: $selection)
            if !game.isGameOver {
                MatchMakers(matches: code.matches)
                    .overlay {
                        if code.kind == .guess {
                            attemptButton
                        }
                    }
            }
        }
    }
}

#Preview {
    CodeBreakerView()
}
