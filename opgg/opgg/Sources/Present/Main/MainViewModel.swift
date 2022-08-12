//
//  MainViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxRelay
import RxSwift

final class MainViewModel: ViewModel {
    struct Action {
        let viewDidLoad = PublishRelay<Void>()
        let tappedMatchs = PublishRelay<Void>()
    }
    
    struct State {
    }
    
    struct SubViewModel {
        let topView = TopViewModel()
        let previousTier = LeaguesViewModel()
    }
    
    let action = Action()
    let state = State()
    let subViewModel = SubViewModel()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        let requestSummoner = action.viewDidLoad
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
        
        subViewModel.topView.action.refresh
            .bind(onNext: {
                print("전적갱신")
            })
            .disposed(by: disposeBag)
        
        summoner
            .map { $0.leagues }
            .bind(to: subViewModel.previousTier.update.leagues)
            .disposed(by: disposeBag)
        
        let requestMatchs = action.tappedMatchs
            .flatMapLatest { [unowned self] _ in
                self.opggRepository.requestMatches(lastMatch: nil)
            }
            .share()
        
        requestMatchs
            .compactMap { $0.value }
            .bind(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
