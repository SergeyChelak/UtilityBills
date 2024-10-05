//
//  ViewHolder.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation
import SwiftUI

typealias ViewIdentifier = UUID

class ViewHolder {
    // add more context fields if needed
    let view: AnyView
    
    init<V: View>(_ view: V) {
        self.view = AnyView(view)
    }
    
    init(_ anyView: AnyView) {
        self.view = anyView
    }
    
    static func empty() -> ViewHolder {
        ViewHolder(EmptyView())
    }
    
    static func `default`() -> ViewHolder {
        ViewHolder(
            Rectangle()
                .foregroundColor(.clear)
                .background(.clear)
        )
    }
}
