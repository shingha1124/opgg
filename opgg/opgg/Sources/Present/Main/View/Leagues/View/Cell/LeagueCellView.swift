//
//  PreviousTierViewCell.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class LeagueCellView: BaseView, View {
    
    private let contentView = UIView()
    private let tierImageView = UIImageView()
    private let rankTypeLabel = UILabel()
    private let tierLabel = UILabel()
    private let lpLabel = UILabel()
    private let matchRecordLabel = UILabel()
    private let winRateLabel = UILabel()
    private let detailButton = UIButton()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: LeagueCellViewModel) {
        tierImageView.setImage(viewModel.state.tier.imageURL)
        rankTypeLabel.text = viewModel.state.tier.name
        tierLabel.text = viewModel.state.tier.tier
        
        let lp = viewModel.state.tier.lp.currency()
        lpLabel.text = "\(lp) LP"
        
        let matchRecord = viewModel.state.matchRecord
        matchRecordLabel.attributedText = matchRecord.text(ofSize: 10)
        winRateLabel.text = "(\(matchRecord.winRate)%)"
    }
    
    override func attribute() {
        super.attribute()
        
        contentView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 4
            $0.layer.shadowColor = UIColor.steelGrey.cgColor
            $0.layer.shadowOpacity = 0.2
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 6
        }
        
        tierImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 32
        }
        
        rankTypeLabel.do {
            $0.font = .appleSDGothicNeo(ofSize: 12)
            $0.textColor = .softBlue
        }
        
        tierLabel.do {
            $0.font = .systemFont(ofSize: 18, weight: .bold)
            $0.textColor = .darkgrey
        }
        
        lpLabel.do {
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.textColor = .darkgrey
        }
        
        matchRecordLabel.do {
            $0.textColor = .steelGrey
        }
        
        winRateLabel.do {
            $0.textColor = .steelGrey
            $0.font = .systemFont(ofSize: 10)
        }
        
        detailButton.do {
            $0.backgroundColor = .paleGrey
            $0.setImage(UIImage(named: "iconArrowRight"), for: .normal)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(contentView)
        contentView.addSubview(tierImageView)
        contentView.addSubview(rankTypeLabel)
        contentView.addSubview(tierLabel)
        contentView.addSubview(lpLabel)
        contentView.addSubview(matchRecordLabel)
        contentView.addSubview(winRateLabel)
        contentView.addSubview(detailButton)
        
        contentView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalTo(matchRecordLabel).offset(16)
        }

        tierImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(64)
        }

        rankTypeLabel.snp.makeConstraints {
            $0.leading.equalTo(tierImageView.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(16)
        }

        tierLabel.snp.makeConstraints {
            $0.top.equalTo(rankTypeLabel.snp.bottom).offset(2)
            $0.leading.equalTo(rankTypeLabel)
        }

        lpLabel.snp.makeConstraints {
            $0.top.equalTo(tierLabel.snp.bottom).offset(2)
            $0.leading.equalTo(rankTypeLabel)
        }

        matchRecordLabel.snp.makeConstraints {
            $0.top.equalTo(lpLabel.snp.bottom).offset(2)
            $0.leading.equalTo(rankTypeLabel)
        }
        
        winRateLabel.snp.makeConstraints {
            $0.centerY.equalTo(matchRecordLabel)
            $0.leading.equalTo(matchRecordLabel.snp.trailing).offset(5)
        }

        detailButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.width.height.equalTo(40)
        }

        snp.makeConstraints {
            $0.bottom.equalTo(contentView)
        }
    }
}
