//
//  SwiftUIMostChampionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class MostChampionViewModel: ObservableObject {
    struct State {
        var championImageUrl: URL?
        var matchRecord = MatchRecord(wins: 0, losses: 0)
        var visibility: ViewVisibility = .gone
    }
    
    struct Update {
        let champion = PublishRelay<Champion?>()
    }
    
    @Published var state = State()
    let index: Int
    let update = Update()
    let disposeBag = DisposeBag()
    
    init(_ index: Int) {
        self.index = index
        
        update.champion
            .bind(onNext: { [unowned self] champion in
                self.state.visibility = champion == nil ? .gone : .visible
                guard let champion = champion else {
                    return
                }
                self.state.championImageUrl = champion.imageUrl
                self.state.matchRecord = MatchRecord(champion)
            })
            .disposed(by: disposeBag)
    }
}
