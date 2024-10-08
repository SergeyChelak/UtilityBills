//
//  BadgeViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 08.10.2024.
//

import SwiftUI

struct BadgeViewModifier: ViewModifier {
    let count: Int
    let max: Int
    
    var foregroundColor: Color = .white
    var backgroundColor: Color = .red
    var fontSize: CGFloat
    
    var value: String? {
        guard count > 0 else {
            return nil
        }
        if count <= max {
            return String(count)
        }
        return "\(max)+"
    }
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            if let value {
                Text(value)
                    .font(.system(size: fontSize))
                    .foregroundStyle(foregroundColor)
                    .padding(.horizontal, 3)
                    .background(backgroundColor)
                    .clipShape(Capsule())
            }
        }
    }
}

extension View {
    func customBadge(_ count: Int, max: Int = 10, fontSize: CGFloat = 10.0) -> some View {
        modifier(BadgeViewModifier(
            count: count,
            max: max,
            fontSize: fontSize
        ))
    }
}

#Preview {
    Image(systemName: "bell")
        .font(.title)
        .customBadge(1, max: 10)
}
