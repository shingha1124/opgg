//
//  PositionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class PositionViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let viewModels = PublishRelay<[PositionItemViewModel]>()
    }
    
    struct Update {
        let positions = PublishRelay<[Position]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.positions
            .map { positions in
                positions.sorted {
                    MatchRecord($0).winRate > MatchRecord($1).winRate
                }[safe: 0..<Environment.positionViewMaxCount]
            }
            .map { $0.map { PositionItemViewModel(position: $0) } }
            .bind(to: state.viewModels)
            .disposed(by: disposeBag)
    }
}
