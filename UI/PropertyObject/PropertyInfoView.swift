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
        HStack(spacing: 12) {
            VStack(alignment: .leading) {
                Text("Object")
                Text("Details")
                Text("UUID")
            }
            
            VStack(alignment: .leading) {
                Text(propertyObject.name)
                    .lineLimit(1)
                Text(propertyObject.details)
                    .lineLimit(1)
                Text(propertyObject.id.uuidString)
                    .lineLimit(1)
            }
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
