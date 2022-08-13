//
//  GamesViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation
import RxRelay
import RxSwift

final class GamesViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let cellViewModels = PublishRelay<[GamesTableViewCellModel]>()
        let reloadData = PublishRelay<Void>()
    }
    
    struct Update {
        let games = BehaviorRelay<[Game]>(value: [])
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        update.games
            .scan([Game](), accumulator: +)
            .map { $0.map { GamesTableViewCellModel(game: $0) } }
            .do { [unowned self] viewModels in
                self.state.cellViewModels.accept(viewModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
    }
}
