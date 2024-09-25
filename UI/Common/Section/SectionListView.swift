//
//  SectionListView.swift
//  UtilityBills
//
//  Created by Sergey on 25.09.2024.
//

import SwiftUI

typealias SectionListSelectionCallback<T> = (T) -> Void
typealias SectionListCellProducer<T, V: View> = (T) -> V

struct SectionListView<T, V: View>: View {
    let items: [T]
    let selectionCallback: SectionListSelectionCallback<T>
    let emptyListMessage: String
    let cellProducer: SectionListCellProducer<T, V>
    
    init(
        items: [T],
        emptyListMessage: String = "",
        selectionCallback: @escaping SectionListSelectionCallback<T>,
        cellProducer: @escaping SectionListCellProducer<T, V>
    ) {
        self.items = items
        self.emptyListMessage = emptyListMessage
        self.selectionCallback = selectionCallback
        self.cellProducer = cellProducer
    }
    
    var body: some View {
        VStack {
            if items.isEmpty {
                Text(emptyListMessage)
            } else {
                ForEach(items.indices, id: \.self) { i in
                    let item = items[i]
                    cellProducer(item)
                        .onTapGesture {
                            selectionCallback(item)
                        }
                        .padding(4)
                    if i < items.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    let meter1 = Meter(
        id: UUID(),
        name: "Hot Water",
        capacity: 9,
        inspectionDate: nil)

    let meter2 = Meter(
        id: UUID(),
        name: "Cold Water",
        capacity: 9,
        inspectionDate: nil)

    
    return SectionListView(
        items: [meter1, meter2],
        emptyListMessage: "You have no meters yet",
        selectionCallback: { _ in },
        cellProducer: { CaptionValueCell(caption: $0.name) }
    )
}
