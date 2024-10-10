//
//  PopoverTitleViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import Foundation
import SwiftUI

struct PopoverTitleViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .lineLimit(1)
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding(.top, 12)
    }
}

extension Text {
    func popoverTitle() -> some View {
        modifier(PopoverTitleViewModifier())
    }
}
