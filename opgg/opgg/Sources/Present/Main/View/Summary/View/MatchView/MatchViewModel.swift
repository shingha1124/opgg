//
//  MatchViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class MatchViewModel: ViewModel {
    
    struct Action {
    }
    
    struct State {
        let gamePlayCount = PublishRelay<Int>()
        let matchRecord = PublishRelay<MatchRecord>()
        let matchKDA = PublishRelay<MatchKDA>()
    }
    
    struct Update {
        let summary = PublishRelay<Summary>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.summary
            .map { $0.wins + $0.losses }
            .bind(to: state.gamePlayCount)
            .disposed(by: disposeBag)
        
        update.summary
            .map { MatchRecord($0) }
            .bind(to: state.matchRecord)
            .disposed(by: disposeBag)
        
        update.summary
            .map { MatchKDA($0) }
            .bind(to: state.matchKDA)
            .disposed(by: disposeBag)
    }
}
