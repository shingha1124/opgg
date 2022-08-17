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
        var winRate = WinRate(wins: 0, losses: 0)
        var kda = KDA()
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
            .map { WinRate($0) }
            .bind(onNext: { [unowned self] winRate in
                self.state.winRate = winRate
            })
            .disposed(by: disposeBag)
        
        update.summary
            .map { KDA($0) }
            .bind(onNext: { [unowned self] kda in
                self.state.kda = kda
            })
            .disposed(by: disposeBag)
    }
}
