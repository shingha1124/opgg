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
        viewModel.state.viewModels
            .forEach { viewModels in
                let view = MostChampionView()
                view.viewModel = viewModels
                contentView.addArrangedSubview(view)
            }
    }
    
    override func attribute() {
        super.attribute()
        
        title.do {
            $0.text = "Most Champion".localized()
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
    }
    
    private func createItemView(_ viewModel: [MostChampionViewModel]) {
        contentView.removeFullyAllArrangedSubviews()
        viewModel.forEach {
            let view = MostChampionView()
            view.viewModel = $0
            contentView.addArrangedSubview(view)
        }
    }
}
