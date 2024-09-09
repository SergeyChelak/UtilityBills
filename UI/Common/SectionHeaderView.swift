//
//  SectionHeaderView.swift
//  UtilityBills
//
//  Created by Sergey on 09.09.2024.
//

import SwiftUI

typealias HeaderActionCallback = () -> Void

//struct HeaderModel {
//    let title: String
//    let action: HeaderAction?
//}

struct HeaderAction {
    let title: String
    let imageDescriptor: ImageDescriptor?
    let callback: HeaderActionCallback
}

struct SectionHeaderView: View {
    let title: String
    let action: HeaderAction?
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .fontWeight(.semibold)
            Spacer()
            if let action {
                if let descriptor = action.imageDescriptor {
                    UBImage(descriptor: descriptor)
                }
                Text(action.title)
                    .onTapGesture(perform: action.callback)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let action = HeaderAction(
        title: "Press",
        imageDescriptor: .system("plus"),
        callback: { print("tap") }
    )
    return SectionHeaderView(title: "Header", action: action)
}
