//
//  SwiftUIMostChampionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUIMostChampionViewModel: ObservableObject {
    struct Action {
    }
    
    struct State {
        let championImageUrl: URL
        let matchRecord: MatchRecord
    }
    
    let index: Int
    let action = Action()
    @Published var state: State
    let disposeBag = DisposeBag()
    
    init(champion: Champion, at index: Int) {
        self.index = index
        let championImageUrl = champion.imageURL
        let matchRecord = MatchRecord(champion)
        state = State(championImageUrl: championImageUrl, matchRecord: matchRecord)
    }
}
