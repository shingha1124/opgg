//
//  RankView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class LeaguesView: BaseView, UIKitView {
    private let scrollView = LeaguesScrollView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: LeaguesViewModel) {
        viewModel.state.cellViewModels
            .bind(to: scrollView.rx.items)
            .disposed(by: disposeBag)
        
        viewModel.state.reloadData
            .bind(onNext: scrollView.reloadData)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
    }
    
    override func layout() {
        super.layout()
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        snp.makeConstraints {
            $0.height.equalTo(scrollView)
        }
    }
}
