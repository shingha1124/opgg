//
//  SwiftUIGamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

struct SwiftUIGamesView: View {
    
    @ObservedObject private var viewModel: SwiftUIGamesViewModel
    
    init(_ viewModel: SwiftUIGamesViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 4) {
            ForEach(viewModel.state.viewModels) { viewModel in
                SwiftUIGamesItemView(viewModel)
            }
            
            HStack {
                Spacer()
                Button(action: {
                    viewModel.update.moreGames.accept(())
                }, label: {
                    Text("전적갱신")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 11, leading: 20, bottom: 11, trailing: 20))
                })
                Spacer()
            }
        }
        .padding([.top], 4)
    }
}

struct SwiftUIGamesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIGamesView(SwiftUIGamesViewModel())
    }
}
