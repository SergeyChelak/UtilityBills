//
//  ChoiceCellViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import SwiftUI

struct ChoiceCellViewModifier: ViewModifier {
    let isSelected: Bool
    
    private var fillColor: Color {
        isSelected ? .brown : .clear
    }
    
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(fillColor)
            )
            .padding(.horizontal, 1)
    }
}
