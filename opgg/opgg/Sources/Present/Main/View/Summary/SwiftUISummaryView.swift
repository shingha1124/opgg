//
//  SwiftUISummaryView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUISummaryView: View {
    
    @ObservedObject private var viewModel: SwiftUISummaryViewModel
    private let matchView: SwiftUIMatchView
    private let mostView: SwiftUIMostView
    private let positionView: SwiftUIPositionView
    
    init(_ viewModel: SwiftUISummaryViewModel) {
        self.viewModel = viewModel
        matchView = SwiftUIMatchView(viewModel.subViewModel.match)
        mostView = SwiftUIMostView(viewModel.subViewModel.most)
        positionView = SwiftUIPositionView(viewModel.subViewModel.position)
    }
    
    var body: some View {
        HStack {
            matchView
            Spacer()
            mostView
            Spacer()
            positionView
        }
        .padding(12)
        .background(.white)
    }
}

struct SwiftUISummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUISummaryView(SwiftUISummaryViewModel())
    }
}
