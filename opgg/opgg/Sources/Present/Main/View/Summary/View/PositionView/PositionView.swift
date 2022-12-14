//
//  PositionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class PositionView: BaseView, View {
    
    private let title = UILabel()
    private let contentView = UIStackView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: PositionViewModel) {
        viewModel.state.viewModels
            .bind(onNext: createItemView)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        title.do {
            $0.text = "Position".localized()
            $0.font = .appleSDGothicNeo(ofSize: 10)
            $0.textColor = .coolGrey
        }
        
        contentView.do {
            $0.axis = .horizontal
            $0.spacing = 16
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(title)
        addSubview(contentView)
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(title).offset(32)
            $0.width.equalTo(contentView).offset(32)
        }
    }
    
    private func createItemView(_ viewModel: [PositionItemViewModel]) {
        contentView.removeFullyAllArrangedSubviews()
        viewModel.forEach {
            let view = PositionItemView()
            view.viewModel = $0
            contentView.addArrangedSubview(view)
        }
    }
}
