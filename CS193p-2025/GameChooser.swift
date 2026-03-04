//
//  GameChooser.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 3/2/26.
//

import SwiftUI

struct GameChooser: View {
    @State private var selection: CodeBreaker? = nil
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            GameListView(selection: $selection)
                .navigationTitle("Code Breaker")
                .toolbar {
                    EditButton()
                }
        } detail: {
            if let selection {
                CodeBreakerView(game: selection)
            } else {
                Text("Choose a game")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    GameChooser()
}
