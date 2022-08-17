//
//  SwiftUIPositionItemViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class PositionItemViewModel: ObservableObject {
    struct State {
        var positionImageName = ""
        var winRate = WinRate(wins: 0, losses: 0)
    }
    
    struct Update {
        let position = PublishRelay<Position?>()
    }
    
    @Published var state = State()
    let update = Update()
    let index: Int
    let disposeBag = DisposeBag()
    
    init(_ index: Int) {
        self.index = index
        
        update.position
            .compactMap { $0?.type.imageName }
            .bind(onNext: { [unowned self] imageName in
                self.state.positionImageName = imageName
            })
            .disposed(by: disposeBag)
        
        update.position
            .compactMap { $0 }
            .map { WinRate($0) }
            .bind(onNext: { [unowned self] winRate in
                self.state.winRate = winRate
            })
            .disposed(by: disposeBag)
    }
}
