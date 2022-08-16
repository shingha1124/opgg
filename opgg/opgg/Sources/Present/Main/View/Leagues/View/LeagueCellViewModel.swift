//
//  SwiftUILeagueCellViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class LeagueCellViewModel: ObservableObject {
    let index: Int
    
    struct State {
        var tier = PreviousTier()
        var matchRecord = MatchRecord(wins: 0, losses: 0)
        var visibility: ViewVisibility = .gone
    }
    
    struct Update {
        let league = PublishRelay<League?>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init(_ index: Int) {
        self.index = index
        
        update.league
            .bind(onNext: { [unowned self] league in
                self.state.visibility = league == nil ? .gone : .visible
                guard let league = league else {
                    return
                }
                self.state.tier = league.tierRank
                self.state.matchRecord = MatchRecord(league)
            })
            .disposed(by: disposeBag)
    }
}
