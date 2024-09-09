//
//  SectionViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct SectionViewModifier: ViewModifier {
    let title: String
    let action: HeaderAction?

    func body(content: Content) -> some View {
        VStack(spacing: 4) {
            SectionHeaderView(
                title: title,
                action: action
            )
            content
                .frame(maxWidth: .infinity)
                .padding(12)
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .padding(.horizontal)
        }
    }
}

extension View {
    func sectionWith(title: String, action: HeaderAction? = nil) -> some View {
        self.modifier(SectionViewModifier(title: title, action: action))
    }
}

#Preview {
    let action = HeaderAction(
        title: "Press",
        imageDescriptor: .system("minus"),
        callback: { print("tap") }
    )
    return Text("Hello, World!")
        .sectionWith(title: "Section", action: action)
}
