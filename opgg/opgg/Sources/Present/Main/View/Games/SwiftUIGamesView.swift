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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIGamesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIGamesView(SwiftUIGamesViewModel())
    }
}
