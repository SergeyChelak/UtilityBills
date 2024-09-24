//
//  CTAButton.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

typealias CTAButtonCallback = () -> Void

struct CTAButton: View {
    let caption: String
    let fillColor: Color
    let maxWidth: CGFloat
    let callback: CTAButtonCallback
    
    init(
        caption: String,
        maxWidth: CGFloat = .infinity,
        fillColor: Color = .blue,
        callback: @escaping CTAButtonCallback
    ) {
        self.caption = caption
        self.maxWidth = maxWidth
        self.fillColor = fillColor
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
}

#Preview {
    CTAButton(caption: "Press") { }
}
