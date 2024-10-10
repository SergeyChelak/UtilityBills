//
//  ObjectListCell.swift
//  UtilityBills
//
//  Created by Sergey on 28.08.2024.
//

import SwiftUI

struct HomeCardView: View {
    let card: HomeCard
    let presenter: HomeCardPresenter
        
    var body: some View {
        VStack {
            UBImage(holder: presenter.cardImage(card))
                .padding(.bottom, 10)
            Text(presenter.cardTitle(card))
                .font(.headline)
                .lineLimit(1)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
            
            Text(presenter.cardSubtitle(card))
                .font(.subheadline)
                .lineLimit(2)
                .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
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
    let item = _propertyObject()
    let card = HomeCard.propertyObject(item)
    return HomeCardView(
        card: card,
        presenter: iOSHomeCardPresenter()
    )
    .frame(width: 150, height: 150)
}
