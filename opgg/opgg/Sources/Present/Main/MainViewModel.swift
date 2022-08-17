//
//  MainViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxRelay
import RxSwift

final class MainViewModel: ObservableObject {
    struct Action {
        let onAppear = PublishRelay<Void>()
        let moreGames = PublishRelay<Void>()
        let changeGamesViewHeight = PublishRelay<CGFloat>()
        let changeScrollHeight = PublishRelay<CGFloat>()
        let changeScrollOffsetHeight = PublishRelay<CGFloat>()
    }
    
    struct State {
        var updatedGames = 0
    }
    
    struct SubViewModel {
        let games = GamesViewModel()
        let topView = TopViewModel()
        let leagues = LeaguesViewModel()
        let summary = SummaryViewModel()
    }
    
    let action = Action()
    @Published var state = State()
    let subViewModel = SubViewModel()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        let requestData = Observable
            .merge(
                action.onAppear.asObservable(),
                subViewModel.topView.action.update.asObservable()
            )

        let requestSummoner = requestData
            .flatMapLatest { [unowned self] _ in
                self.opggRepository.requestSummonerInfo()
            }
            .share()

        let summoner = requestSummoner
            .compactMap { $0.value }
            .map { $0.summoner }
            .share()

        summoner
            .bind(to: subViewModel.topView.update.summoner)
            .disposed(by: disposeBag)

        summoner
            .map { $0.leagues }
            .bind(to: subViewModel.leagues.update.leagues)
            .disposed(by: disposeBag)

        let requestMatchs = requestData
            .flatMapLatest { [unowned self] _ in
                self.opggRepository.requestMatches(lastMatch: nil)
            }
            .share()

        let matches = requestMatchs
            .compactMap { $0.value }
            .share()

        matches
            .bind(to: subViewModel.summary.update.matches)
            .disposed(by: disposeBag)

        matches
            .map { $0.games }
            .bind(to: subViewModel.games.update.updateGames)
            .disposed(by: disposeBag)

        action.moreGames
            .skip(1)
            .bind(to: subViewModel.games.update.moreGames)
            .disposed(by: disposeBag)
        
//        Observable
//            .combineLatest(
//                action.changeGamesViewHeight.asObservable(),
//                action.changeScrollHeight.asObservable(),
//                action.changeScrollOffsetHeight.asObservable()
//            )
////            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
//            .filter { gamesHeight, contentHeight, offsetHeight in
//                if offsetHeight.isZero {
//                    return false
//                }
//                let originY = contentHeight - gamesHeight
//                let scrollOffset = offsetHeight * -1 + originY
//                print(gamesHeight - scrollOffset)
//                return gamesHeight - scrollOffset < 80
//            }
//            .map { _ in }
//            .bind(to: subViewModel.games.update.moreGames)
//            .disposed(by: disposeBag)
//        
//        subViewModel.games.state.updatedGames
//            .bind(onNext: { [unowned self] lastIndex in
//                self.state.updatedGames = lastIndex
//            })
//            .disposed(by: disposeBag)
    }
}
