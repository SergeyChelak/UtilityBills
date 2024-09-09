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
    let title: String?
    let imageDescriptor: ImageDescriptor?
    let callback: HeaderActionCallback
    
    init(title: String? = nil, imageDescriptor: ImageDescriptor? = nil, callback: @escaping HeaderActionCallback) {
        self.title = title
        self.imageDescriptor = imageDescriptor
        self.callback = callback
    }
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
                HStack(spacing: 4) {
                    if let descriptor = action.imageDescriptor {
                        UBImage(descriptor: descriptor)
                            .foregroundStyle(.selection)
                    }
                    if let title = action.title {
                        Text(title)
                            .foregroundStyle(.selection)
                    }
                }
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
