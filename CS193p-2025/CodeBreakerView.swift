//
//  CodeBreakerView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(pegChoices: [.indigo, .pink, .purple, .blue])
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices, id: \.self) { index in
                    view (for: game.attempts[index])
                }
            }
        }
        .padding()
    }
    
    var attemptButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                    .contentShape(Rectangle())
                    .overlay {
                        if code.kind == .guess {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.gray)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
            }

            MatchMakers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        attemptButton
                    }
                }
        }
    }
}

#Preview {
    CodeBreakerView()
}
