//
//  InputStyleViewModifier.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct InputStyleViewModifier: ViewModifier {
    let caption: String?
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            if let caption {
                Text(caption)
                    .lineLimit(1)
            }
            content
            #if os(iOS)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.fill)
                )
                .padding(.horizontal, 1)
            #endif                
        }
    }
}

extension View {
    func inputStyle(caption: String? = nil) -> some View {
        modifier(InputStyleViewModifier(caption: caption))
    }
}

#Preview {
    var text = "Villa California"
    let binding = Binding(get: { text }, set: { text = $0 })
    return TextField("Placeholder:", text: binding)
        .inputStyle(caption: "Name")
}
