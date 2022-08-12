//
//  MostViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import RxRelay
import RxSwift

final class MostViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let viewModels = PublishRelay<[MostChampionViewModel]>()
    }
    
    struct Update {
        let champions = PublishRelay<[Champion]>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.champions
            .map { $0.map { MostChampionViewModel(champion: $0) } }
            .bind(to: state.viewModels)
            .disposed(by: disposeBag)
    }
}
