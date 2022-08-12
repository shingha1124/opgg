//
//  TopViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxRelay
import RxSwift

final class TopViewModel: ViewModel {
    struct Action {
        let refresh = PublishRelay<Void>()
    }
    
    struct State {
        let profileImageURL = PublishRelay<URL>()
        let level = PublishRelay<Int>()
    }
    
    struct Update {
        let summoner = PublishRelay<Summoner>()
    }
    
    let action = Action()
    let state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.summoner
            .map { $0.profileImageURL }
            .bind(to: state.profileImageURL)
            .disposed(by: disposeBag)
        
        update.summoner
            .map { $0.level }
            .bind(to: state.level)
            .disposed(by: disposeBag)
    }
}
