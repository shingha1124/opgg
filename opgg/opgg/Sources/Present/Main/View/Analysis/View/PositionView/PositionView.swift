//
//  PositionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class PositionView: BaseView, View {
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: PositionViewModel) {
        
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = .blue
        }
    }
    
    override func layout() {
        super.layout()
        
        snp.makeConstraints {
            $0.width.equalTo(64)
        }
    }
}

