//
//  SwiftUILeaguesViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class LeaguesViewModel: ObservableObject {    
    struct State {
        var cellViewModels = (0..<Environment.leagueViewMaxCount).map { LeagueCellViewModel($0) }
    }
    
    struct Update {
        let leagues = PublishRelay<[League]>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.leagues
            .bind(onNext: { [unowned self] leagues in
                self.state.cellViewModels.enumerated().forEach {
                    $1.update.league.accept(leagues[optional: $0])
                }
            })
            .disposed(by: disposeBag)
    }
}
