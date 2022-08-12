//
//  PositionViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation
import RxRelay
import RxSwift

final class PositionItemViewModel: ViewModel {
    struct Action {
    }
    
    struct State {
        let positionImageName: String
        let matchRecord: MatchRecord
    }
    
    let action = Action()
    let state: State
    let disposeBag = DisposeBag()
    
    init(position: Position) {
        let positionImageName = position.type.imageName
        let matchRecord = MatchRecord(position)
        state = State(positionImageName: positionImageName, matchRecord: matchRecord)
    }
}
