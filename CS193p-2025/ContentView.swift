//
//  ContentView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/19/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs([.blue, .red, .yellow, .green])
        }
        .padding()
    }
    
    func pegs(_ colors: [Color]) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMakers(matches: [.correctPosition, .correctPosition, .wrongPosition, .notInTheCode])
        }
    }
}

#Preview {
    ContentView()
}
