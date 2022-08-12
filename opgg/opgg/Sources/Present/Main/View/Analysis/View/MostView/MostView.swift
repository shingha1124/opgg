//
//  MostView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MostView: BaseView, View {
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MostViewModel) {
        
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = .red
        }
    }
    
    override func layout() {
        super.layout()
        
        snp.makeConstraints {
            $0.width.equalTo(98)
        }
    }
}

