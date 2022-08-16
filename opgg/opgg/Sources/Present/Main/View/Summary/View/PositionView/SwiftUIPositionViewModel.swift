//
//  SwiftUIPositionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUIPositionViewModel: ObservableObject {
    struct Action {
    }
    
    struct State {
        var viewModels = [SwiftUIPositionItemViewModel]()
    }
    
    struct Update {
        let positions = PublishRelay<[Position]>()
    }
    
    let action = Action()
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.positions
            .map { positions in
                positions.sorted {
                    MatchRecord($0).winRate > MatchRecord($1).winRate
                }[safe: 0..<1]
            }
            .map { $0.enumerated().map { SwiftUIPositionItemViewModel(position: $1, at: $0) } }
            .bind(onNext: { [unowned self] viewModels in
                self.state.viewModels = viewModels
            })
            .disposed(by: disposeBag)
    }
}
