//
//  SwiftUIPositionItemView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUIPositionItemView: View {
    
    @ObservedObject private var viewModel: SwiftUIPositionItemViewModel
    
    init(_ viewModel: SwiftUIPositionItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(viewModel.state.positionImageName)
            .frame(width: 24, height: 24)
            
            Text("\(viewModel.state.matchRecord.winRate)%")
                .font(.system(size: 10))
                .foregroundColor(viewModel.state.matchRecord.winRateColor)
        }
    }
}

//struct SwiftUIPositionItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIPositionItemView(SwiftUIPositionItemViewModel())
//    }
//}
