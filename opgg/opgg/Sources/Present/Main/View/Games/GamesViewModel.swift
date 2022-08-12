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
        let games = PublishRelay<[Game]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        update.games
            .map { $0.map { GamesTableViewCellModel(game: $0) } }
            .do { [unowned self] viewModels in
                self.state.cellViewModels.accept(viewModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
        
        action.moreGames
            .bind(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
        let requestMoreGames = action.moreGames
            .withLatestFrom(update.games) { _, games in games.last }
            .flatMapLatest { [unowned self] lastGame in
                self.opggRepository.requestMatches(lastMatch: lastGame?.createDate)
            }
            .share()

//        let moreGames =
        requestMoreGames
            .compactMap { $0.value?.games }
            .bind(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
        
    }
}
