//
//  SwiftUIMainView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUIMainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    private let topView: TopView
    private let leaguesView: LeaguesView
    private let summaryView: SummaryView
    
    init() {
        let viewModel = MainViewModel()
        topView = TopView(viewModel.subViewModel.swiftUITopViewModel)
        leaguesView = LeaguesView(viewModel.subViewModel.swiftUILeaguesViewModel)
        summaryView = SummaryView(viewModel.subViewModel.swiftUISummaryViewModel)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                topView
                leaguesView
                summaryView
            }
            .ignoresSafeArea()
        }
        .background(Color.paleGrey)
        .onAppear {
            viewModel.action.onAppear.accept(())
        }
    }
}

struct SwiftUIMainView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMainView()
    }
}
