//
//  TopViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Foundation
import RxRelay
import RxSwift

final class TopViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
    }
    
    let action = Action()
    let state = State()
    let disposeBag = DisposeBag()
    
    init() {
    }
}
