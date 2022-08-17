//
//  SwiftUIGamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Introspect
import SwiftUI

struct GamesView: View {
    
    @ObservedObject private var viewModel: GamesViewModel
    @State var rowHeight: CGFloat = 0
    
    init(_ viewModel: GamesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 4) {
            ForEach(viewModel.state.viewModels) { model in
                GamesItemView(model)
                    .frame(minHeight: self.rowHeight)
                    .listRowInsets(.init())
                    .background(
                        GeometryReader { proxy  in
                            Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                        }
                    )
                    .onPreferenceChange(SizePreferenceKey.self) { preferences in
                        let currentSize: CGSize = preferences
                        if currentSize.height > self.rowHeight {
                            self.rowHeight = currentSize.height
                        }
                    }
                    .onAppear {
                        if model.index == viewModel.state.viewModels.count - 1 {
                            viewModel.action.loadMore.accept(())
                        }
                    }
            }
        }
        .padding([.top], 4)
        .background(Color.paleGrey2)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue = CGSize.zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}

struct GamesView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GamesViewModel()
        let view = GamesView(viewModel)
        
        let games = (0..<30).map { _ in Game() }
        viewModel.update.updateGames.accept(games)
        
        return view
    }
}
