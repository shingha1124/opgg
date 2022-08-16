//
//  RankViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class LeaguesViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let cellViewModels = PublishRelay<[LeagueCellViewModel]>()
        let reloadData = PublishRelay<Void>()
    }
    
    struct Update {
        let leagues = PublishRelay<[League]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.leagues
            .map { $0.map { LeagueCellViewModel(league: $0) } }
            .do { [unowned self] viewModels in
                self.state.cellViewModels.accept(viewModels)
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
    }
}
