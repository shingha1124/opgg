//
//  MostViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class MostViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let viewModels = (0..<Environment.mostChampionViewMaxCount).map { _ in MostChampionViewModel() }
    }
    
    struct Update {
        let champions = PublishRelay<[Champion]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.champions
            .map { champions in
                Array(champions.sorted {
                    MatchRecord($0).winRate > MatchRecord($1).winRate
                }[safe: 0..<Environment.mostChampionViewMaxCount])
            }
            .bind(onNext: { [unowned self] champions in
                self.state.viewModels.enumerated().forEach {
                    $1.update.champion.accept(champions[optional: $0])
                }
            })
            .disposed(by: disposeBag)
    }
}
