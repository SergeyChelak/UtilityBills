//
//  CaptionValueCell.swift
//  UtilityBills
//
//  Created by Sergey on 10.09.2024.
//

import SwiftUI

struct CaptionValueCell: View {
    let caption: String
    let value: String
    
    init(caption: String, value: String = "") {
        self.caption = caption
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(caption)
                .foregroundStyle(.primary)
                .lineLimit(1)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    CaptionValueCell(
        caption: "Caption",
        value: "value"
    )
}
