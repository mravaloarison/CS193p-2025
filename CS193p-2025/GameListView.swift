//
//  GameListView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 3/3/26.
//

import SwiftUI

struct GameListView: View {
    @State private var games = [CodeBreaker]()
    @Binding var selection: CodeBreaker?
    
    var body: some View {
        List(selection: $selection) {
            ForEach(games) { game in
                NavigationLink(value: game) {
                    GameSummaryView(game: game)
                }
            }
            .onDelete { offsets in
                games.remove(atOffsets: offsets)
            }
            .onMove { offsets, destination in
                games.move(fromOffsets: offsets, toOffset: destination)
            }
        }
        .onChange(of: games) {
            if let selection, !games.contains(selection) {
                self.selection = nil
            }
        }
        .onAppear {
            if games.isEmpty {
                addSampleGames()
            }
        }
        .listStyle(.plain)
    }
    
    func addSampleGames() {
        if games.isEmpty {
            games.append(CodeBreaker(name: "Game 1", pegChoices: [.blue, .yellow, .indigo, .green]))
            games.append(CodeBreaker(name: "Second Colors", pegChoices: [.cyan, .blue, .purple, .brown]))
            games.append(CodeBreaker(name: "Last Game", pegChoices: [.black, .yellow, .pink]))
            selection = games[Int.random(in: 0..<games.count)]
        }
    }
}

#Preview {
    @Previewable @State var selection: CodeBreaker?
    NavigationStack {
        GameListView(selection: $selection)
    }
}
