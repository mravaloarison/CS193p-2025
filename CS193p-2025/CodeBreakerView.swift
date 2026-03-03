//
//  CodeBreakerView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

struct CodeBreakerView: View {
    let game: CodeBreaker
    @State private var selection: Int = 0
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            guessesView
            Spacer()
            KeyboardView
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                restartButton
            }
        }
        .padding()
    }
    
    var restartButton: some View {
        Button {
            game.restart()
            selection = 0
        } label: {
            Image(systemName: "arrow.trianglehead.counterclockwise")
            Text("Restart")
        }
    }
    
    var guessesView: some View {
        ScrollView {
            if !game.isGameOver {
                view(for: game.guess)
            }
            ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                view (for: game.attempts[index])
            }
        }
    }
    
    var KeyboardView: some View {
        HStack {
            PegChooser(choices: game.pegChoices, isGameOver: game.isGameOver) { peg in
                game.changeGuessPeg(to: peg, at: selection)
                selection = (selection + 1) % game.pegChoices.count
            }
            
            if !game.isGameOver {
                undoChangesButton
            }
        }
    }
    
    var attemptButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
            game.resetGuess()
            selection = 0
        }
        .disabled(!game.hasAtLeastOneGuess)
    }
    
    var undoChangesButton: some View {
        Button {
            let codeLength = game.pegChoices.count
            let latestChangeIndex = (selection - 1 + codeLength) % codeLength
            game.undoChange(at: latestChangeIndex)
            selection = latestChangeIndex
        } label: {
            HStack {
                Image(systemName: "arrow.uturn.backward")
                Text("Undo")
            }
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
    @Previewable @State var game = CodeBreaker(name: "Player", pegChoices: [.brown, .cyan, .blue, .purple])
    NavigationStack {
        CodeBreakerView(game: game)
    }
}
