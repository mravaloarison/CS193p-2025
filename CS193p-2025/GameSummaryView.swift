//
//  GameSummaryView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 3/2/26.
//

import SwiftUI

struct GameSummaryView: View {
    let game: CodeBreaker
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name).font(.title)
            PegChooser(choices: game.pegChoices, isGameOver: false, onChoose: {_ in
                print("do nothing")
            })
            .frame(maxHeight: 50)
            Text("^[\(game.attempts.count) attempt](inflectr: true)")
        }
    }
}

#Preview {
    @Previewable @State var game = CodeBreaker(name: "Test Preview", pegChoices: [.red, .blue, .yellow, .green])
    GameSummaryView(game: game)
}
