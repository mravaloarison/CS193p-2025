//
//  PegChooser.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/24/26.
//

import SwiftUI

struct PegChooser: View {
    let choices: [Peg]
    let isGameOver: Bool
    let onChoose: ((Peg) -> Void)?
    
    var body: some View {
        if isGameOver {
            Text("🥳 Congratulations! You win!")
        } else {
            HStack {
                ForEach(choices, id: \.self) { peg in
                    Button {
                        onChoose?(peg)
                    } label: {
                        ConstantPeg.shape                            .contentShape(Rectangle())
                            .foregroundStyle(peg)
                            .aspectRatio(1, contentMode: .fit)
                    }
                }
            }
        }
    }
}
