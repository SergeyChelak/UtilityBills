//
//  EditPropertyInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct EditPropertyInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var propertyObject: PropertyObject
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("Dismiss") {
                dismiss()
            }
        }
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    dismiss()
                }
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
    return EditPropertyInfoView(propertyObject: obj)
}
