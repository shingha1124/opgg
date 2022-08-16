//
//  SwiftUISummaryView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUISummaryViewModel: ObservableObject {
    struct Action {
    }
    
    struct State {
    }
    
    struct SubViewModel {
        let match = SwiftUIMatchViewModel()
        let most = SwiftUIMostViewModel()
        let position = SwiftUIPositionViewModel()
    }
    
    struct Update {
        let matches = PublishRelay<Matches>()
    }
    
    let action = Action()
    let state = State()
    let subViewModel = SubViewModel()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.matches
            .map { $0.summary }
            .bind(to: subViewModel.match.update.summary)
            .disposed(by: disposeBag)
        
        update.matches
            .map { $0.champions }
            .bind(to: subViewModel.most.update.champions)
            .disposed(by: disposeBag)

        update.matches
            .map { $0.positions }
            .bind(to: subViewModel.position.update.positions)
            .disposed(by: disposeBag)
    }
}
