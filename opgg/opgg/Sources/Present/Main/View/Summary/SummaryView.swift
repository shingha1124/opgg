//
//  SwiftUISummaryView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SummaryView: View {
    
    @ObservedObject private var viewModel: SummaryViewModel
    private let matchView: MatchView
    private let mostView: MostView
    private let positionView: PositionView
    
    init(_ viewModel: SummaryViewModel) {
        self.viewModel = viewModel
        matchView = MatchView(viewModel.subViewModel.match)
        mostView = MostView(viewModel.subViewModel.most)
        positionView = PositionView(viewModel.subViewModel.position)
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
        SummaryView(SummaryViewModel())
    }
}
