//
//  PropertyInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct PropertyInfoView: View {
    let propertyObject: PropertyObject
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CaptionValueCell(
                caption: "Object",
                value: propertyObject.name
            )
            Divider()
            CaptionValueCell(
                caption: "Details",
                value: propertyObject.details
            )
        }
    }
}

#Preview {
    let obj = PropertyObject(
        id: UUID(),
        name: "Villa",
        details: "Unknown Road, 42"
    )
    return PropertyInfoView(propertyObject: obj)
}
