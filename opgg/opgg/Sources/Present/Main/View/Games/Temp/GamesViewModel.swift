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
        let moreGames = PublishRelay<Void>()
    }
    
    struct State {
        let cellViewModels = PublishRelay<[GamesTableViewCellModel]>()
        let reloadData = PublishRelay<Void>()
    }
    
    struct Update {
        let updateGames = BehaviorRelay<[Game]>(value: [])
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        let updateGames = update.updateGames
            .map { $0.map { GamesTableViewCellModel(game: $0) } }
            .share()
        
        let requestMoreGames = action.moreGames
            .withLatestFrom(state.cellViewModels) { $1.last?.state.game.createDate }
            .flatMapLatest { [unowned self] lastDate in
                self.opggRepository.requestMatches(lastMatch: lastDate)
            }
            .share()
        
        let moreGames = requestMoreGames
            .compactMap { $0.value?.games }
            .map { $0.map { GamesTableViewCellModel(game: $0) } }
            .withLatestFrom(state.cellViewModels) { $1 + $0 }
            .share()
        
        Observable
            .merge(updateGames, moreGames )
            .do { [unowned self] viewModels in
                self.state.cellViewModels.accept(viewModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
    }
}
