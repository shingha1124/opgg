//
//  SwiftUIMainView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUIMainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    private let topView: SwiftUITopView
    private let leaguesView: SwiftUILeaguesView
    private let summaryView: SwiftUISummaryView
    
    init() {
        let viewModel = MainViewModel()
        topView = SwiftUITopView(viewModel.subViewModel.swiftUITopViewModel)
        leaguesView = SwiftUILeaguesView(viewModel.subViewModel.swiftUILeaguesViewModel)
        summaryView = SwiftUISummaryView(viewModel.subViewModel.swiftUISummaryViewModel)
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
//            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
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
