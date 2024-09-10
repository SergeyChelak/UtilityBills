//
//  EditPropertyInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

typealias EditPropertyInfoViewCTACallback = (PropertyObject) throws -> Void

struct EditPropertyInfoView: View {
    @Environment(\.dismiss) var dismiss
    @State var propertyObject: PropertyObject
    let callback: EditPropertyInfoViewCTACallback
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Object Properties")
                .padding(.top, 12)
            Spacer()
            TextField("", text: $propertyObject.name)
                .inputStyle(caption: "Title")
                        
            TextField("", text: $propertyObject.details)
                .inputStyle(caption: "Details")
            
            Spacer()
            CTAButton(caption: "Save") {
                do {
                    try callback(propertyObject)
                    dismiss()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            .padding(.bottom, 12)
        }
        .padding(.horizontal)
    }
}

#Preview {
    let obj = PropertyObject(
        id: UUID(),
        name: "Villa",
        details: "Unknown Road, 42"
    )
    return EditPropertyInfoView(propertyObject: obj) { _ in }
}
