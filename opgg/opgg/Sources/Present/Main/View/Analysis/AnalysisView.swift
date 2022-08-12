//
//  AnalysisView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class AnalysisView: BaseView, View {
    var disposeBag = DisposeBag()
    
    private let contentView = UIStackView()
    private let matchView = MatchView()
    private let mostView = MostView()
    private let positionView = PositionView()
    
    func bind(to viewModel: AnalysisViewModel) {
        matchView.viewModel = viewModel.subViewModel.match
    }
    
    override func attribute() {
        super.attribute()
        
        self.do {
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor.steelGrey.cgColor
            $0.layer.shadowOpacity = 0.1
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 2
        }
        
        contentView.do {
            $0.axis = .horizontal
            $0.spacing = 0
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(contentView)
        contentView.addArrangedSubview(matchView)
        contentView.addArrangedSubview(mostView)
        contentView.addArrangedSubview(positionView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(matchView)
        }
    }
}
