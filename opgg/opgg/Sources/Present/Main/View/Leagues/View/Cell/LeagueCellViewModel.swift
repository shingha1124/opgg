//
//  LeagueCellViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class LeagueCellViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let tier: PreviousTier
        let matchRecord: MatchRecord
    }
    
    struct Update {
    }
    
    let action = Action()
    let state: State
    let update = Update()
    let disposeBag = DisposeBag()
    
    init(league: League) {
        state = State(tier: league.tierRank, matchRecord: MatchRecord(league))
    }
}
