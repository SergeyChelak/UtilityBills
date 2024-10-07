//
//  ObjectListCell.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import SwiftUI

struct HomeCardView: View {
    let card: HomeCard
    
    var title: String {
        switch card {
        case .propertyObject(let propertyObject):
            propertyObject.name
        case .addNewObjectAction:
            "New"
        }
    }
    
    var subtitle: String {
        switch card {
        case .propertyObject(let propertyObject):
            propertyObject.details
        case .addNewObjectAction:
            "Tap to add new property object"
        }
    }
    
    var imageDescriptor: ImageDescriptor {
        switch card {
        case .propertyObject:
            ImageDescriptor(type: .system, name: "house.fill")
        case .addNewObjectAction:
            ImageDescriptor(type: .system, name: "plus.circle")
        }
    }
    
    var body: some View {
        VStack {
            UBImage(descriptor: imageDescriptor)
                .padding(.bottom, 10)
            Text(title)
                .font(.headline)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
            
            if !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.primary, lineWidth: 1)
        )
    }
}

#Preview {
    let item = PropertyObject(
        id: UUID(),
        name: "House",
        details: "Best Street, 74",
        currencyId: nil
    )
    let card = HomeCard.propertyObject(item)
    return HomeCardView(card: card)
        .frame(width: 150, height: 150)
}
