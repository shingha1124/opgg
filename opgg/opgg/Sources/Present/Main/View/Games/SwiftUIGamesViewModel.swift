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
    }
    
    struct Update {
    }
    
    @Published var state = State()
    let update = Update()
    let disposeBag = DisposeBag()
    
    init() {
    }
}
