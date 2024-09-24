//
//  ObjectListCell.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import SwiftUI

struct ObjectListCell: View {
    let item: PropertyObject
    
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                
                if !item.details.isEmpty {
                    Text(item.details)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.secondary)
                }
            }
        }
        .contentShape(Rectangle())
    }
}

#Preview {
    let item = PropertyObject(
        id: UUID(),
        name: "House",
        details: "Best Street, 74",
        currencyId: nil
    )
    return ObjectListCell(item: item)
}
