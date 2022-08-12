//
//  MatchView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MatchView: BaseView, View {
    private let matchDescription = UILabel()
    private let matchRecord = UILabel()
    private let kdaLabel = UILabel()
    private let kdaRate = UILabel()
    private let winRate = UILabel()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MatchViewModel) {
        viewModel.state.gamePlayCount
            .map {
                .appendAttributedString([
                    .stringToOption("최근 "),
                    .stringToOption("\($0)", attributes: [.font(.systemFont(ofSize: 10))]),
                    .stringToOption("게임 분석")
                ])
            }
            .bind(to: matchDescription.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { .matchRecordText($0, ofSize: 10) }
            .bind(to: matchRecord.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchKDA
            .map { .kdaText($0, ofSize: 14) }
            .bind(to: kdaLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchKDA
            .map { .kdaRateText($0, ofSize: 10) }
            .bind(to: kdaRate.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { .matchRateText($0, ofSize: 10) }
            .bind(to: winRate.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        matchDescription.do {
            $0.font = .appleSDGothicNeo(ofSize: 10)
            $0.textColor = .coolGrey
        }
        
        matchRecord.do {
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .coolGrey
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(matchDescription)
        addSubview(matchRecord)
        addSubview(kdaLabel)
        addSubview(kdaRate)
        addSubview(winRate)
        
        matchDescription.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        
        matchRecord.snp.makeConstraints {
            $0.top.equalTo(matchDescription.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(12)
        }
        
        kdaLabel.snp.makeConstraints {
            $0.top.equalTo(matchRecord.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(12)
        }
        
        kdaRate.snp.makeConstraints {
            $0.top.equalTo(kdaLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().offset(12)
        }
        
        winRate.snp.makeConstraints {
            $0.centerY.equalTo(kdaRate)
            $0.leading.equalTo(kdaRate.snp.trailing).offset(5)
        }
    }
}
