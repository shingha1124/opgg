//
//  SwiftUIMostChampionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct MostChampionView: View {
    
    @ObservedObject private var viewModel: MostChampionViewModel
    
    init(_ viewModel: MostChampionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 4) {
            AsyncImage(url: viewModel.state.championImageUrl) { image in
                image.resizable()
            } placeholder: {
                Color.paleGrey2
            }
            .frame(width: 30, height: 30)
            .clipShape(Capsule())
            
            Text("\(viewModel.state.matchRecord.winRate)%")
                .font(.system(size: 10))
                .foregroundColor(viewModel.state.matchRecord.winRateColor)
        }
        .visibility(viewModel.state.visibility)
    }
}

//struct SwiftUIMostChampionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIMostChampionView(SwiftUIMostChampionViewModel()
//    }
//}
