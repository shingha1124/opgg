//
//  SwiftUIMainView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI
import Combine

struct SwiftUIMainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    private let topView: TopView
    private let leaguesView: LeaguesView
    private let summaryView: SummaryView
    private let gamesView: SwiftUIGamesView
    private let detector: CurrentValueSubject<CGFloat, Never>
    private let publisher: AnyPublisher<CGFloat, Never>
    
    @State private var gamesViewHeight: CGFloat = 0
    
    init() {
        let viewModel = MainViewModel()
        topView = TopView(viewModel.subViewModel.topView)
        leaguesView = LeaguesView(viewModel.subViewModel.leagues)
        summaryView = SummaryView(viewModel.subViewModel.summary)
        gamesView = SwiftUIGamesView(viewModel.subViewModel.games)
        
        self.viewModel = viewModel
        
        let detector = CurrentValueSubject<CGFloat, Never>(0)
        self.publisher = detector
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
            .dropFirst()
            .eraseToAnyPublisher()
        self.detector = detector
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                topView
                leaguesView
                summaryView
                gamesView
            }
        }
        .background(Color.greenBlue)
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

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
//        value += nextValue()
    }
}
