//
//  GameSummonerView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

final class GameSummonerView: BaseView {
    private let championImage = UIImageView()
    private let scoreBadge = PaddingLabel()
    
    private let spells = [UIImageView(), UIImageView()]
    private let peaks = [UIImageView(), UIImageView()]
    
    private let kdaLabel = UILabel()
    private let contributionForKillRate = UILabel()
    
    override func attribute() {
        super.attribute()
        
        championImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
        }
        
        scoreBadge.do {
            $0.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
            $0.isCapsule = true
            $0.font = .systemFont(ofSize: 10, weight: .bold)
            $0.clipsToBounds = true
            $0.textColor = .white
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.white.cgColor
        }
        
        spells.forEach {
            $0.do {
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 4
            }
        }
        
        peaks.forEach {
            $0.do {
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 9.5
            }
        }
        
        contributionForKillRate.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .gunmetal
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(championImage)
        addSubview(scoreBadge)
        addSubview(spells[0])
        addSubview(spells[1])
        addSubview(peaks[0])
        addSubview(peaks[1])
        addSubview(kdaLabel)
        addSubview(contributionForKillRate)
        
        championImage.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        
        scoreBadge.snp.makeConstraints {
            $0.centerX.equalTo(championImage)
            $0.top.equalTo(championImage).offset(30)
        }
        
        spells[0].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(championImage.snp.trailing).offset(4)
            $0.width.height.equalTo(19)
        }
        
        spells[1].snp.makeConstraints {
            $0.top.equalTo(spells[0].snp.bottom).offset(2)
            $0.leading.equalTo(spells[0])
            $0.width.height.equalTo(19)
        }
        
        peaks[0].snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(spells[0].snp.trailing).offset(2)
            $0.width.height.equalTo(19)
        }
        
        peaks[1].snp.makeConstraints {
            $0.top.equalTo(peaks[0].snp.bottom).offset(2)
            $0.leading.equalTo(peaks[0])
            $0.width.height.equalTo(19)
        }
        
        kdaLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(2)
            $0.leading.equalTo(peaks[0].snp.trailing).offset(8)
        }
        
        contributionForKillRate.snp.makeConstraints {
            $0.leading.equalTo(kdaLabel)
            $0.top.equalTo(kdaLabel.snp.bottom).offset(2)
        }
        
        snp.makeConstraints {
            $0.trailing.equalTo(kdaLabel)
            $0.bottom.equalTo(championImage)
        }
    }
    
    func setGameData(_ game: Game) {
        let general = game.stats.general
        
        championImage.setImage(game.champion.imageUrl)
        championImage.layer.borderWidth = general.opScoreBadge == .empty ? 0 : 2
        championImage.layer.borderColor = general.opScoreBadge.color.cgColor
        
        scoreBadge.text = general.opScoreBadge.name
//        scoreBadge.backgroundColor = general.opScoreBadge.color
        scoreBadge.isHidden = general.opScoreBadge == .empty
        
        spells.enumerated().forEach { index, spell in
            spell.setImage(game.spells[index].imageUrl)
        }
        
        peaks.enumerated().forEach { index, peak in
            peak.setImage(game.peak[index])
        }
        
        let gameKda = GameKDA(general)
        kdaLabel.attributedText = gameKda.kdaText(ofSize: 16)
    
        contributionForKillRate.text = String(format: "KillParticipate".localized(), general.contributionForKillRate)
    }
}
