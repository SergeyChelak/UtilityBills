//
//  TitleSubtitleCell.swift
//  UtilityBills
//
//  Created by Sergey on 08.09.2024.
//

import SwiftUI

struct TitleSubtitleCell: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.title)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    TitleSubtitleCell(
        title: "Hello",
        subtitle: "More information about..."
    )
}
