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
        VStack(alignment: .leading) {
            Text(item.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            Text(item.details ?? item.id.uuidString)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
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
