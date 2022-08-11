//
//  RankViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class PreviousTierViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let previousTier = PublishRelay<[PreviousTier]>()
    }
    
    struct Update {
        let previousTier = PublishRelay<[PreviousTier]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.previousTier
            .bind(to: state.previousTier)
            .disposed(by: disposeBag)
    }
}
