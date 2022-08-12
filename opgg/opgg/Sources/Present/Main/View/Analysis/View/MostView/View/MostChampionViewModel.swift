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
        let champion: Champion
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init(champion: Champion) {
        state = State(champion: champion)
    }
}
