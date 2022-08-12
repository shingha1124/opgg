//
//  GamesViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation
import RxRelay
import RxSwift

final class GamesViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
    }
    
    struct Update {
        let games = PublishRelay<[Game]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
    }
}
