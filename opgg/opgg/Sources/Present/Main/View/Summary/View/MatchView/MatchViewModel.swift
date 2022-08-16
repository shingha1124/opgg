//
//  SwiftUIMatchViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class MatchViewModel: ObservableObject {
    struct State {
        var gamePlayCount: Int = 0
        var matchRecord = MatchRecord(wins: 0, losses: 0)
        var matchKDA = MatchKDA()
    }
    
    struct Update {
        let summary = PublishRelay<Summary>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.summary
            .map { $0.wins + $0.losses }
            .bind(onNext: { [unowned self] count in
                self.state.gamePlayCount = count
            })
            .disposed(by: disposeBag)
        
        update.summary
            .map { MatchRecord($0) }
            .bind(onNext: { [unowned self] matchRecord in
                self.state.matchRecord = matchRecord
            })
            .disposed(by: disposeBag)
        
        update.summary
            .map { MatchKDA($0) }
            .bind(onNext: { [unowned self] matchKDA in
                self.state.matchKDA = matchKDA
            })
            .disposed(by: disposeBag)
    }
}
