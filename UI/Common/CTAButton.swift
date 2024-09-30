//
//  CTAButton.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

typealias CTAButtonCallback = () -> Void

enum CTAButtonStyle {
    case normal
    case destructive
}

struct CTAButton: View {
    let caption: String
    let style: CTAButtonStyle
    let maxWidth: CGFloat
    let callback: CTAButtonCallback
    
    init(
        caption: String,
        maxWidth: CGFloat = .infinity,
        style: CTAButtonStyle = .normal,
        callback: @escaping CTAButtonCallback
    ) {
        self.caption = caption
        self.maxWidth = maxWidth
        self.style = style
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
        switch style {
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
