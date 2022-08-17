//
//  SwiftUIGamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import Foundation
import RxRelay
import RxSwift

final class SwiftUIGamesViewModel: ObservableObject {
    struct State {
        var viewModels = [SwiftUIGamesItemViewModel]()
        var isLoading = false
        let updatedGames = PublishRelay<Int>()
    }
    
    struct Update {
        let updateGames = PublishRelay<[Game]>()
        let moreGames = PublishRelay<Void>()
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        update.updateGames
            .map { $0.enumerated().map { SwiftUIGamesItemViewModel($0.element, at: $0.offset) } }
            .bind(onNext: { [unowned self] viewModels in
                self.state.viewModels = viewModels
            })
            .disposed(by: disposeBag)
        
        let requestMoreGames = update.moreGames
            .filter { [unowned self] _ in
                !self.state.isLoading
            }
            .do { [unowned self] _ in
                self.state.isLoading = true
            }
            .compactMap { [unowned self] _ in
                self.state.viewModels.last?.state.game.createDate
            }
            .flatMapLatest { [unowned self] lastDate in
                self.opggRepository.requestMatches(lastMatch: lastDate)
            }
            .share()
        
        requestMoreGames
            .compactMap { $0.value?.games }
            .do { [unowned self] new in
                let newGames = new.enumerated().map {
                    SwiftUIGamesItemViewModel( $0.element, at: self.state.viewModels.count + $0.offset)
                }
                self.state.viewModels += newGames
            }
            .delay(.seconds(2), scheduler: MainScheduler.asyncInstance)
            .do { [unowned self] _ in
                self.state.isLoading = false
            }
            .map { [unowned self] new in
                self.state.viewModels.count - new.count
            }
            .bind(to: state.updatedGames)
            .disposed(by: disposeBag)
    }
}
