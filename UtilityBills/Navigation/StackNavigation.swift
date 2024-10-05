//
//  StackNavigation.swift
//  UtilityBills
//
//  Created by Sergey on 05.10.2024.
//

import Foundation

protocol StackNavigation {
    func push(_ holder: ViewHolder)
    func pop()
    func popToRoot()
    func showSheet(_ holder: ViewHolder)
    func hideSheet()
    func setRoot(_ holder: ViewHolder)
}
