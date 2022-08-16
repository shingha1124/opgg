//
//  SwiftUITopViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/14.
//

import Foundation
import RxRelay
import RxSwift
import SwiftUI

final class SwiftUITopViewModel: ObservableObject {
    struct Action {
        let update = PublishRelay<Void>()
    }
    
    struct State {
        var profileImageURL: URL? = nil
        var level = 0
    }
    
    struct Update {
        let summoner = PublishRelay<Summoner>()
    }
        
    
    let action = Action()
    @Published var state = State()
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
