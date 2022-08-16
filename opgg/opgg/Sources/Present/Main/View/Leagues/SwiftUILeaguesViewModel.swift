//
//  SwiftUILeaguesViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUILeaguesViewModel: ObservableObject {
    struct Action {
    }
    
    struct State {
        var cellViewModels = [SwiftUILeagueCellViewModel]()
        let reloadData = PublishRelay<Void>()
    }
    
    struct Update {
        let leagues = PublishRelay<[League]>()
    }
    
    let action = Action()
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
        update.leagues
            .map { $0.enumerated().map { SwiftUILeagueCellViewModel(league: $1, at: $0) } }
            .do { [unowned self] viewModels in
                self.state.cellViewModels = viewModels
            }
            .map { _ in }
            .bind(to: state.reloadData)
            .disposed(by: disposeBag)
    }
}
