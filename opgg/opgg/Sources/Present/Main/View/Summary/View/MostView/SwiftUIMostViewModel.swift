//
//  SwiftUIMostViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUIMostViewModel: ObservableObject {
    struct Action {
    }
    
    struct State {
        var viewModels = [SwiftUIMostChampionViewModel]()
    }
    
    struct Update {
        let champions = PublishRelay<[Champion]>()
    }
    
    let action = Action()
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.champions
            .map { champions in
                champions.sorted {
                    MatchRecord($0).winRate > MatchRecord($1).winRate
                }[safe: 0..<2]
            }
            .map { $0.enumerated().map { SwiftUIMostChampionViewModel(champion: $1, at: $0) } }
            .bind(onNext: { [unowned self] viewModels in
                self.state.viewModels = viewModels
            })
            .disposed(by: disposeBag)
    }
}
