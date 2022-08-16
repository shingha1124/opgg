//
//  SwiftUITopViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/14.
//

import Foundation
import RxRelay
import RxSwift

final class TopViewModel: ObservableObject {
    struct Action {
        let update = PublishRelay<Void>()
    }
    
    struct State {
        var profileImageURL: URL?
        var level = 0
    }
    
    struct Update {
        let summoner = PublishRelay<Summoner>()
    }
     
    @Published var state = State()
    let action = Action()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.summoner
            .bind(onNext: { [unowned self] summoner in
                self.state.profileImageURL = summoner.profileImageURL
                self.state.level = summoner.level
            })
            .disposed(by: disposeBag)
    }
}
