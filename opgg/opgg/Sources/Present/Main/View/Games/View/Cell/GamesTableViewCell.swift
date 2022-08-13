//
//  GamesTableViewCell.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation
import UIKit

final class GamesTableViewCell: BaseTableViewCell, View {
    
    private let gameResultView = UIView()
    private let playResultLabel = UILabel()
    private let playTime = UILabel()
    private let centerBar = UIView()
    
    private let gameSummaryView = UIView()
    private let gameSummonerView = GameSummonerView()
    private let gameItemsView = GameItemsView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameItemsView.prepareForReuse()
    }
    
    func bind(to viewModel: GamesTableViewCellModel) {
        let game = viewModel.state.game
        gameResultView.backgroundColor = game.isWin ? .softBlue : .darkishPink
        playResultLabel.text = game.isWin ? "Wins".localized() : "Losses".localized()
        
        let playTimeMin = game.gameLength / 60
        let playTimeSec = game.gameLength % 60
        playTime.text = "\(playTimeMin):\(playTimeSec)"
        
        gameSummonerView.setGameData(game)
        gameItemsView.setItems(game.items)
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.selectionStyle = .none
        }
        
        gameResultView.do {
            $0.backgroundColor = .softBlue
        }
        
        playResultLabel.do {
            $0.font = .appleSDGothicNeo(ofSize: 16, weight: .bold)
            $0.textColor = .white
        }
        
        playTime.do {
            $0.font = .systemFont(ofSize: 12)
            $0.textColor = .white
        }
        
        centerBar.do {
            $0.backgroundColor = .white
        }
    }
    
    override func layout() {
        super.layout()
        
        contentView.addSubview(gameResultView)
        gameResultView.addSubview(centerBar)
        gameResultView.addSubview(playResultLabel)
        gameResultView.addSubview(playTime)
        
        contentView.addSubview(gameSummaryView)
        gameSummaryView.addSubview(gameSummonerView)
        gameSummaryView.addSubview(gameItemsView)
        
        gameResultView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        centerBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        playResultLabel.snp.makeConstraints {
            $0.bottom.equalTo(centerBar.snp.top).offset(-6)
            $0.centerX.equalToSuperview()
        }
        
        playTime.snp.makeConstraints {
            $0.top.equalTo(centerBar.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        
        gameSummaryView.snp.makeConstraints {
            $0.leading.equalTo(gameResultView.snp.trailing)
            $0.top.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        gameSummonerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        gameItemsView.snp.makeConstraints {
            $0.top.equalTo(gameSummonerView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
}
