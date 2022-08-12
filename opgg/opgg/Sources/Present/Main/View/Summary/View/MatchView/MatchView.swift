//
//  MatchView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MatchView: BaseView, View {
    private let matchTitle = UILabel()
    private let matchRecord = UILabel()
    private let kdaLabel = UILabel()
    private let kdaRate = UILabel()
    private let winRate = UILabel()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MatchViewModel) {
        viewModel.state.gamePlayCount
            .map {
                .appendAttributedString([
                    .stringToOption("SummaryTitlePrefix".localized()),
                    .stringToOption("\($0)", attributes: [.font(.systemFont(ofSize: 10))]),
                    .stringToOption("SummaryTitleSuffix".localized())
                ])
            }
            .bind(to: matchTitle.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { $0.text(ofSize: 10) }
            .bind(to: matchRecord.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchKDA
            .map { $0.kdaText(ofSize: 14) }
            .bind(to: kdaLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.state.matchKDA
            .map { String(format: "%.2f:1", $0.kdaRate) }
            .bind(to: kdaRate.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.state.matchKDA
            .map { $0.kdaRateColor }
            .bind(to: kdaRate.rx.textColor)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { "(\($0.winRate)%)" }
            .bind(to: winRate.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.state.matchRecord
            .map { $0.winRateColor }
            .bind(to: winRate.rx.textColor)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        matchTitle.do {
            $0.font = .appleSDGothicNeo(ofSize: 10)
            $0.textColor = .coolGrey
        }
        
        matchRecord.do {
            $0.font = .systemFont(ofSize: 10)
            $0.textColor = .coolGrey
        }
        
        winRate.do {
            $0.font = .systemFont(ofSize: 10)
        }
        
        kdaRate.do {
            $0.font = .systemFont(ofSize: 10)
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(matchTitle)
        addSubview(matchRecord)
        addSubview(kdaLabel)
        addSubview(kdaRate)
        addSubview(winRate)
        
        matchTitle.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(12)
        }
        
        matchRecord.snp.makeConstraints {
            $0.top.equalTo(matchTitle.snp.bottom).offset(8)
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
        
        snp.makeConstraints {
            $0.trailing.equalTo(kdaLabel).offset(12)
            $0.bottom.equalTo(kdaRate).offset(12)
        }
    }
}
