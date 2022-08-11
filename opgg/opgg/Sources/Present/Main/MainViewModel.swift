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
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    @Inject(\.opggRepository) private var opggRepository: OpggRepository
    
    init() {
        let requestSummoner = action.viewDidLoad
            .flatMapLatest { [unowned self] _ in
                self.opggRepository.requestSummonerInfo()
            }
            .share()
        
        requestSummoner
            .compactMap { $0.value }
            .bind(onNext: {
                print($0)
            })
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
