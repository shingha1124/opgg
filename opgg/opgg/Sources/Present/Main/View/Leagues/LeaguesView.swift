//
//  SwiftUILeaguesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct LeaguesView: View {
    
    @ObservedObject private var viewModel: LeaguesViewModel
    
    init(_ viewModel: LeaguesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        let screenSize = UIScreen.main.bounds.size
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(viewModel.state.cellViewModels, id: \.index) { viewModel in
                    LeagueCellView(viewModel)
                        .frame(width: screenSize.width - 48, height: nil)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 48 - 16))
        }
    }
}

struct SwiftUILeaguesView_Previews: PreviewProvider {
    static var previews: some View {
        LeaguesView(LeaguesViewModel())
    }
}
