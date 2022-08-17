//
//  SwiftUIGamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Foundation
import RxRelay
import RxSwift

final class GamesViewModel: ObservableObject {
    struct Action {
        let loadMore = PublishRelay<Void>()
    }
    
    struct State {
        var viewModels = [GamesItemViewModel]()
        var isLoading = BehaviorRelay<Bool>(value: false)
    }
    
    struct Update {
        let updateGames = PublishRelay<[Game]>()
    }
    
    @Published var state = State()
    let action = Action()
    let update = Update()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        update.updateGames
            .map { $0.enumerated().map { GamesItemViewModel($0.element, at: $0.offset) } }
            .bind(onNext: { [unowned self] viewModels in
                self.state.viewModels = viewModels
            })
            .disposed(by: disposeBag)
        
        let requestMoreGames = action.loadMore
            .filter { [unowned self] _ in
                !self.state.isLoading.value
            }
            .do { [unowned self] _ in
                self.state.isLoading.accept(true)
            }
            .compactMap { [unowned self] _ in
                self.state.viewModels.last?.state.game.createDate
            }
            .flatMapLatest { [unowned self] lastDate in
                self.opggRepository.requestMatches(lastMatch: lastDate)
            }
            .do { [unowned self] _ in
                self.state.isLoading.accept(false)
            }
            .share()
        
        requestMoreGames
            .compactMap { $0.value?.games }
            .bind(onNext: { [unowned self] new in
                let prevCount = self.state.viewModels.count
                let newGames = new.enumerated().map { index, game in
                    GamesItemViewModel( game, at: prevCount + index)
                }
                self.state.viewModels += newGames
            })
            .disposed(by: disposeBag)
    }
}
