//
//  SwiftUILeagueCellViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUILeagueCellViewModel: ObservableObject {
    let index: Int
    
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
    
    init(league: League, at index: Int) {
        self.index = index
        state = State(tier: league.tierRank, matchRecord: MatchRecord(league))
    }
}
