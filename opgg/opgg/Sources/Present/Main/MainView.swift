//
//  SwiftUIMainView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    private let topView: TopView
    private let leaguesView: LeaguesView
    private let summaryView: SummaryView
    private let gamesView: GamesView
    
    init() {
        let viewModel = MainViewModel()
        topView = TopView(viewModel.subViewModel.topView)
        leaguesView = LeaguesView(viewModel.subViewModel.leagues)
        summaryView = SummaryView(viewModel.subViewModel.summary)
        gamesView = GamesView(viewModel.subViewModel.games)
        
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                topView
                leaguesView
                summaryView
                gamesView  
            }
        }
        .padding([.top], 1)
        .background(Color.paleGrey)
        .onAppear {
            viewModel.action.onAppear.accept(())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
