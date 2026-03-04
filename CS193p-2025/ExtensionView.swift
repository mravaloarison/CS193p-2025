//
//  ExtensionView.swift
//  CS193p-2025
//
//  Created by Mami RavaLoarison on 3/3/26.
//

import SwiftUI

extension View {
    func flexibleSystemFont(minimum: CGFloat = 8, maximum: CGFloat = 80) -> some View {
        self
            .font(.system(size: maximum))
            .minimumScaleFactor(minimum/maximum)
    }
}
