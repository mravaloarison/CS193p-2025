//
//  PegsView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 2/24/26.
//

import SwiftUI

struct PegsView: View {
    var code: Code
    @Binding var selection: Int
    
    var body: some View {
        ForEach(code.pegs.indices, id: \.self) { index in
            ConstantPeg.shape
                .contentShape(ConstantPeg.shape)
                .overlay {
                    if code.kind == .guess {
                        let strokeColor: Color = (selection == index) ? .blue : .gray
                        let boldIfActive: Int = (selection == index) ? 4 : 1
                        ConstantPeg.shape
                            .strokeBorder(strokeColor, lineWidth: CGFloat(boldIfActive))
                    } else if code.isHidden {
                        ConstantPeg.shape
                            .foregroundStyle(.gray)
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(code.pegs[index])
                .onTapGesture {
                    if code.kind == .guess {
                        selection = index
                    }
                }
        }
    }
}
