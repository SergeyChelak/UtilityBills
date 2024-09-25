//
//  MetersInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct MetersInfoView: View {
    let meters: [Meter]
    let meterSelectionCallback: (MeterId) -> Void
    
    var body: some View {
        VStack {
            if meters.isEmpty {
                Text("You have no meters yet")
            } else {
                ForEach(meters.indices, id: \.self) { i in
                    CaptionValueCell(caption: meters[i].name)
                        .onTapGesture {
                            meterSelectionCallback(meters[i].id)
                        }
                        .padding(4)
                    if i < meters.count - 1 {
                        Divider()
                    }
                }
            }
        }
    }
}

#Preview {
    let meter = Meter(
        id: UUID(),
        name: "Hot Water",
        capacity: 9,
        inspectionDate: nil)
    return MetersInfoView(meters: [meter]) { _ in }
}
