//
//  GameChooser.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 3/2/26.
//

import SwiftUI

struct GameChooser: View {
    @State private var games: [CodeBreaker] = []
    
    var body: some View {
        NavigationStack {
            List($games, id: \.pegChoices, editActions: [.delete, .move]) { $game in
                NavigationLink(value: game) {
                    GameSummaryView(game: game)
                }
            }
            .listStyle(.plain)
            .toolbar {
                EditButton()
            }
            .navigationDestination(for: CodeBreaker.self) { game in
                    CodeBreakerView(game: game)
            }
        }
        .onAppear {
            games.append(CodeBreaker(name: "Game 1", pegChoices: [.blue, .yellow, .indigo, .green]))
            games.append(CodeBreaker(name: "Second Colors", pegChoices: [.cyan, .blue, .purple, .brown]))
            games.append(CodeBreaker(name: "Last Game", pegChoices: [.black, .yellow, .pink, .red]))
            
        }
    }
}

#Preview {
    GameChooser()
}
