//
//  MostView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MostView: BaseView, View {
    
    private let title = UILabel()
    private let contentView = UIStackView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MostViewModel) {
        viewModel.state.champions
            .bind(onNext: createMostChampionView)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        title.do {
            $0.text = "모스트 승률"
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
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-12)
        }
        
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(title).offset(32)
            $0.width.equalTo(contentView).offset(32)
        }
    }
    
    private func createMostChampionView(_ viewModel: [MostChampionViewModel]) {
        contentView.removeFullyAllArrangedSubviews()
        viewModel.forEach {
            let view = MostChampionView()
            view.viewModel = $0
            contentView.addArrangedSubview(view)
        }
    }
}
