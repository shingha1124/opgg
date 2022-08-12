//
//  PositionItemView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import RxSwift
import UIKit

final class PositionItemView: BaseView, View {
    
    private let positionImage = UIImageView()
    private let winRateLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: PositionItemViewModel) {
        positionImage.image = UIImage(named: viewModel.state.positionImageName)
        let matchRecord = viewModel.state.matchRecord
        winRateLabel.text = "\(matchRecord.winRate)%"
        winRateLabel.textColor = matchRecord.winRateColor
    }
    
    override func attribute() {
        super.attribute()
        winRateLabel.do {
            $0.font = .systemFont(ofSize: 10)
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(positionImage)
        addSubview(winRateLabel)
        
        positionImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        winRateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.greaterThanOrEqualTo(positionImage)
            $0.width.equalTo(winRateLabel)
        }
    }
}
