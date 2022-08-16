//
//  MostChampionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MostChampionView: BaseView, View {
    
    private let championImage = UIImageView()
    private let winRateLabel = UILabel()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MostChampionViewModel) {
        viewModel.state.championImageUrl
            .map { ($0, UIImage(color: .paleGrey2)) }
            .bind(onNext: championImage.setImage)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { "\($0.winRate)%" }
            .bind(to: winRateLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { $0.winRateColor }
            .bind(to: winRateLabel.rx.textColor)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        championImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
        
        winRateLabel.do {
            $0.font = .systemFont(ofSize: 10)
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(championImage)
        addSubview(winRateLabel)
        
        championImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        winRateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.width.equalTo(championImage)
        }
    }
}
