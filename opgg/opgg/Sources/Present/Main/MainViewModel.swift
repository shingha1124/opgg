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
    }
    
    struct State {
    }
    
    struct SubViewModel {
        let topView = TopViewModel()
        let previousTier = LeaguesViewModel()
        let summary = SummaryViewModel()
        let games = GamesViewModel()
        
        let swiftUITopViewModel = SwiftUITopViewModel()
        let swiftUILeaguesViewModel = SwiftUILeaguesViewModel()
        let swiftUISummaryViewModel = SwiftUISummaryViewModel()
    }
    
    let action = Action()
    let state = State()
    let subViewModel = SubViewModel()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        let requestData = Observable
            .merge(
                action.onAppear.asObservable(),
                subViewModel.swiftUITopViewModel.action.update.asObservable()
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
            .bind(to: subViewModel.swiftUITopViewModel.update.summoner)
            .disposed(by: disposeBag)

        summoner
            .map { $0.leagues }
            .bind(to: subViewModel.swiftUILeaguesViewModel.update.leagues)
            .disposed(by: disposeBag)
//
        let requestMatchs = requestData
            .flatMapLatest { [unowned self] _ in
                self.opggRepository.requestMatches(lastMatch: nil)
            }
            .share()

        let matches = requestMatchs
            .compactMap { $0.value }
            .share()

        matches
            .bind(to: subViewModel.swiftUISummaryViewModel.update.matches)
            .disposed(by: disposeBag)
//
//        matches
//            .map { $0.games }
//            .bind(to: subViewModel.games.update.updateGames)
//            .disposed(by: disposeBag)
//
//        action.moreGames
//            .bind(to: subViewModel.games.action.moreGames)
//            .disposed(by: disposeBag)
    }
}
