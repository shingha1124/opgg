//
//  SwiftUIGamesItemViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Foundation
import RxRelay
import RxSwift

final class GamesItemViewModel: ObservableObject, Identifiable {
    struct State {
        let game: Game
        let items: [Item]
        let lastItem: Item?
    }
    
    struct Update {
    }
    
    @Published var state: State
    let index: Int
    let update = Update()
    let disposeBag = DisposeBag()
    
    init(_ game: Game, at index: Int) {
        self.index = index
        let lastItem = game.items.last
        let items = Array(game.items.dropLast())
        self.state = State(game: game, items: items, lastItem: lastItem)
    }
}
