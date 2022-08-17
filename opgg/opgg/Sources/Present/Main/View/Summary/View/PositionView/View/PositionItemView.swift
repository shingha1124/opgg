//
//  SwiftUIPositionItemView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct PositionItemView: View {
    
    @ObservedObject private var viewModel: PositionItemViewModel
    
    init(_ viewModel: PositionItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(viewModel.state.positionImageName)
            .frame(width: 24, height: 24)
            
            Text("\(viewModel.state.winRate.rate)%")
                .font(.system(size: 10))
                .foregroundColor(viewModel.state.winRate.rateColor)
        }
    }
}

struct PositionItemView_Previews: PreviewProvider {
    static var previews: some View {
        PositionItemView(PositionItemViewModel(0))
    }
}
