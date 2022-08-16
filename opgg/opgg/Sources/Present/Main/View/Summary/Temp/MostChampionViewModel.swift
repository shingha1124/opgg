//
//  MostChampionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class MostChampionViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let championImageUrl: URL
        let matchRecord: MatchRecord
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init(champion: Champion) {
        let championImageUrl = champion.imageURL
        let matchRecord = MatchRecord(champion)
        state = State(championImageUrl: championImageUrl, matchRecord: matchRecord)
    }
}
