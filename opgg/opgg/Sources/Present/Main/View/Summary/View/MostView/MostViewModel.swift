//
//  SwiftUIMostViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class MostViewModel: ObservableObject {
    struct State {
        var cellViewModels = (0..<Environment.mostChampionViewMaxCount).map { MostChampionViewModel($0) }
    }
    
    struct Update {
        let champions = PublishRelay<[Champion]>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.champions
            .map { champions in
                Array(champions.sorted {
                    WinRate($0).rate > WinRate($1).rate
                }[safe: 0..<Environment.mostChampionViewMaxCount])
            }
            .bind(onNext: { [unowned self] champions in
                self.state.cellViewModels.enumerated().forEach {
                    $1.update.champion.accept(champions[optional: $0])
                }
            })
            .disposed(by: disposeBag)
    }
}
