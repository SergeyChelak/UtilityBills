//
//  ChoiceView.swift
//  UtilityBills
//
//  Created by Sergey on 28.09.2024.
//

import SwiftUI

typealias ChoiceCellViewBuilder<T, V: View> = (T) -> V

private struct ChoiceView<ItemType, ViewModel: ChoiceViewModel, CellView: View>:
    View where ViewModel.T == ItemType {
    
    @ObservedObject
    var viewModel: ViewModel
    let viewBuilder: ChoiceCellViewBuilder<ItemType, CellView>
    
    init(
        viewModel: ViewModel,
        viewBuilder: @escaping ChoiceCellViewBuilder<ItemType, CellView>
    ) {
        self.viewModel = viewModel
        self.viewBuilder = viewBuilder
    }
    
    var body: some View {
        ForEach(viewModel.items.indices, id: \.self) { i in
            viewBuilder(viewModel.items[i])
                .modifier(ChoiceCellViewModifier(isSelected: viewModel.isSelected[i]))
                .onTapGesture {
                    viewModel.onTap(i)
                }
        }
    }
}

struct VerticalChoiceView<ItemType, ViewModel: ChoiceViewModel, CellView: View>:
    View where ViewModel.T == ItemType {
    
    let viewModel: ViewModel
    let viewBuilder: ChoiceCellViewBuilder<ItemType, CellView>
    
    var body: some View {
        VStack(spacing: 12) {
            ChoiceView(
                viewModel: viewModel,
                viewBuilder: viewBuilder
            )
        }
    }
}

struct GridChoiceView<ItemType, ViewModel: ChoiceViewModel, CellView: View>:
    View where ViewModel.T == ItemType {
    
    let viewModel: ViewModel
    let viewBuilder: ChoiceCellViewBuilder<ItemType, CellView>
    let adaptiveColumn: [GridItem]
    
    init(
        minWidth: CGFloat = 150,
        viewModel: ViewModel,
        viewBuilder: @escaping ChoiceCellViewBuilder<ItemType, CellView>
    ) {
        self.viewModel = viewModel
        self.viewBuilder = viewBuilder
        self.adaptiveColumn = [
            GridItem(.adaptive(minimum: minWidth))
        ]
    }
    
    var body: some View {
        LazyVGrid(columns: adaptiveColumn, spacing: 16) {
            ChoiceView(
                viewModel: viewModel,
                viewBuilder: viewBuilder
            )
        }
    }
}


#Preview("Single/List") {
    let vm = SingleChoiceViewModel(
        items: ["Apple", "Orange", "Banana", "Peach"]
    )
    return VerticalChoiceView(viewModel: vm) { text in
        Text(text)
            .frame(width: 200)
    }
}

#Preview("Multiple/List") {
    let vm = MultiChoiceViewModel(
        items: ["Apple", "Orange", "Banana", "Peach"]
    )
    return VerticalChoiceView(viewModel: vm) { text in
        Text(text)
            .frame(width: 200)
    }
}

#Preview("Multiple/Grid") {
    let vm = MultiChoiceViewModel(
        items: ["Apple", "Orange", "Banana", "Peach"]
    )
    return GridChoiceView(viewModel: vm) { text in
        Text(text)
            .frame(width: 120)
    }
}
