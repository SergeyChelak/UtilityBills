//
//  UBTextField.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct UBTextField: View {
    let caption: String?
    let placeholder: String?
    @Binding var text: String
    
    init(_ caption: String?, placeholder: String? = nil, text: Binding<String>) {
        self.caption = caption
        self.placeholder = placeholder
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            if let caption {
                Text(caption)
                    .lineLimit(1)
            }
            TextField(placeholder ?? "", text: $text)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: .infinity)
                        .fill(.fill)
                        .stroke(Color.primary, lineWidth: 1)
                )
                .padding(.horizontal, 1)
        }
    }
}

#Preview {
    var text = "Villa California"
    let binding = Binding(get: { text }, set: { text = $0 })
    return UBTextField(
        "Name:",
        text: binding
    )
}
