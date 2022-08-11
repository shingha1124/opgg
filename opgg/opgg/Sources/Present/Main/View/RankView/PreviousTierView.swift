//
//  RankView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class RankView: BaseView, View {
    
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: RankViewModel) {
        
    }
    
    override func attribute() {
        super.attribute()
        
        scrollView.do {
            $0.isPagingEnabled = true
        }
        
        contentView.do {
            $0.axis = .horizontal
            $0.spacing = 8
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(scrollView)
        }
    }
}
