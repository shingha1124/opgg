//
//  SwiftUIPositionItemViewModel.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import Foundation
import RxRelay
import RxSwift

final class PositionItemViewModel: ObservableObject {
    struct State {
        let positionImageName: String
        let matchRecord: MatchRecord
    }
    
    let index: Int
    let state: State
    let disposeBag = DisposeBag()
    
    init(position: Position, at index: Int) {
        self.index = index
        let positionImageName = position.type.imageName
        let matchRecord = MatchRecord(position)
        state = State(positionImageName: positionImageName, matchRecord: matchRecord)
    }
}
