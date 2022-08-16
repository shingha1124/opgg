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
        let championImageUrl = PublishRelay<URL>()
        let matchRecord = PublishRelay<MatchRecord>()
    }
    
    struct Update {
        let champion = PublishRelay<Champion?>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.champion
            .compactMap { $0?.imageURL }
            .bind(to: state.championImageUrl)
            .disposed(by: disposeBag)
        
        update.champion
            .compactMap { $0 }
            .map { MatchRecord($0) }
            .bind(to: state.matchRecord)
            .disposed(by: disposeBag)
    }
}
