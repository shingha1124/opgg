//
//  SwiftUIPositionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class PositionViewModel: ObservableObject {    
    struct State {
        var cellViewModels = (0..<Environment.positionViewMaxCount).map { PositionItemViewModel($0) }
    }
    
    struct Update {
        let positions = PublishRelay<[Position]>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.positions
            .map { positions in
                Array(positions.sorted {
                    WinRate($0).rate > WinRate($1).rate
                }[safe: 0..<Environment.positionViewMaxCount])
            }
            .bind(onNext: { [unowned self] positions in
                self.state.cellViewModels.enumerated().forEach {
                    $1.update.position.accept(positions[optional: $0])
                }
            })
            .disposed(by: disposeBag)
    }
}
