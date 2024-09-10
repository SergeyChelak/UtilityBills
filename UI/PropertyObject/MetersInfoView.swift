//
//  MetersInfoView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

struct MetersInfoView: View {
    let meters: [Meter]
    
    var body: some View {
        VStack {
            if meters.isEmpty {
                Text("You have no meters yet")
            } else {
                ForEach(meters.indices, id: \.self) { i in
                    Text(meters[i].name)
                        .frame(maxWidth: .infinity, alignment: .leading)
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
    return MetersInfoView(meters: [meter])
}
