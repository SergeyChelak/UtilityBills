//
//  CTAButton.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

typealias CTAButtonCallback = () -> Void

enum ActionKind {
    case normal
    case destructive
}

struct CTAButton: View {
    let caption: String
    let actionKind: ActionKind
    let maxWidth: CGFloat
    let callback: CTAButtonCallback
    
    init(
        caption: String,
        maxWidth: CGFloat = .infinity,
        actionKind: ActionKind = .normal,
        callback: @escaping CTAButtonCallback
    ) {
        self.caption = caption
        self.maxWidth = maxWidth
        self.actionKind = actionKind
        self.callback = callback
    }
    
    var body: some View {
        Text(caption)
            .foregroundStyle(.white)
            .lineLimit(1)
            .frame(maxWidth: maxWidth)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: .infinity)
                    .fill(fillColor)
            )
            .padding(.horizontal, 1)
            .onTapGesture(perform: callback)
    }
    
    private var fillColor: Color {
        switch actionKind {
        case .normal:
                .blue
        case .destructive:
                .red
        }
    }
}

#Preview {
    CTAButton(caption: "Press") { }
}
