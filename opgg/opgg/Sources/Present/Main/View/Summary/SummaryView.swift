//
//  AnalysisView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class SummaryView: BaseView, View {
    var disposeBag = DisposeBag()
    
    private let backgroundView = UIView()
    private let contentView = UIStackView()
    private let matchView = MatchView()
    private let mostView = MostView()
    private let positionView = PositionView()
    
    func bind(to viewModel: SummaryViewModel) {
        matchView.viewModel = viewModel.subViewModel.match
        mostView.viewModel = viewModel.subViewModel.most
        positionView.viewModel = viewModel.subViewModel.position
    }
    
    override func attribute() {
        super.attribute()
        
        self.do {
            $0.backgroundColor = .clear
        }
        
        backgroundView.do {
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor.steelGrey.cgColor
            $0.layer.shadowOpacity = 0.1
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 2
        }
        
        contentView.do {
            $0.axis = .horizontal
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(backgroundView)
        addSubview(contentView)
        contentView.addArrangedSubview(matchView)
        contentView.addArrangedSubview(mostView)
        contentView.addArrangedSubview(positionView)
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(12)
            $0.bottom.equalTo(matchView)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(contentView).offset(12)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(backgroundView).offset(4)
        }
    }
}
