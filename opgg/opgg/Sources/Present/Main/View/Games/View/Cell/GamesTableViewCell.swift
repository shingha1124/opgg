//
//  GamesTableViewCell.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation
import UIKit

final class GamesTableViewCell: BaseTableViewCell, View {
    
    private let cellBackgroundView = UIView()
    
    private let gameResultView = UIView()
    private let playResultLabel = UILabel()
    private let playTime = UILabel()
    private let centerBar = UIView()
    
    private let gameSummaryView = UIView()
    private let gameSummonerView = GameSummonerView()
    private let gameItemsView = GameItemsView()
    
    private let gameType = UILabel()
    private let gameCreateDate = UILabel()
    private let multikillLabel = PaddingLabel()
    
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
        
        gameType.text = game.gameType.name
        gameCreateDate.attributedText = createDateAttributeText(game.createDate)
        
        let multiKill = game.stats.general.largestMultiKillString
        multikillLabel.text = multiKill.name
        multikillLabel.isHidden = multiKill == .empty
        multikillLabel.textColor = multiKill.color
        multikillLabel.layer.borderColor = multiKill.color.cgColor
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.backgroundColor = .paleGrey
            $0.selectionStyle = .none
        }
        
        cellBackgroundView.do {
            $0.backgroundColor = .white
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
        
        gameType.do {
            $0.font = .appleSDGothicNeo(ofSize: 12)
            $0.textColor = .coolGrey
        }
        
        gameCreateDate.do {
            $0.textColor = .coolGrey
        }
        
        multikillLabel.do {
            $0.padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
            $0.font = .appleSDGothicNeo(ofSize: 10)
            $0.isCapsule = true
            $0.layer.borderWidth = 1
        }
    }
    
    override func layout() {
        super.layout()
        
        contentView.addSubview(cellBackgroundView)
        
        cellBackgroundView.addSubview(gameResultView)
        gameResultView.addSubview(centerBar)
        gameResultView.addSubview(playResultLabel)
        gameResultView.addSubview(playTime)
        
        cellBackgroundView.addSubview(gameSummaryView)
        gameSummaryView.addSubview(gameSummonerView)
        gameSummaryView.addSubview(gameItemsView)
        
        cellBackgroundView.addSubview(gameType)
        cellBackgroundView.addSubview(gameCreateDate)
        cellBackgroundView.addSubview(multikillLabel)
        
        cellBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(gameItemsView).offset(16)
        }
        
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
        
        gameType.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        gameCreateDate.snp.makeConstraints {
            $0.top.equalTo(gameType.snp.bottom).offset(1)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        multikillLabel.snp.makeConstraints {
            $0.centerY.equalTo(gameItemsView)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(cellBackgroundView).offset(4)
        }
    }
    
    private func createDateAttributeText(_ createDate: Int) -> NSAttributedString {
        let createDate = Date(timeIntervalSince1970: TimeInterval(createDate))
        let diff = Calendar.current.dateComponents([.minute, .hour, .day], from: createDate, to: Date())
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        
        var createDateText = dateFormatter.string(from: createDate)
        var createDateValue: Int?
        if let day = diff.day, day > 1 {
            createDateValue = day <= 7 ? day : nil
            createDateText = day <= 7 ? "Day Ago".localized() : createDateText
        } else if let hour = diff.hour, hour > 1 {
            createDateValue = hour
            createDateText = "Hour Ago".localized()
        } else if let minute = diff.minute {
            createDateValue = minute
            createDateText = "Minute Ago".localized()
        } else {
            createDateText = "방금 전"
        }
        var attributedTexts = [NSAttributedString]()
        if let value = createDateValue {
            attributedTexts.append(.stringToOption(
                "\(value)",
                attributes: [
                    .font(.systemFont(ofSize: 12))
                ]))
        }
        attributedTexts.append(.stringToOption(
            createDateText,
            attributes: [
                .font(.appleSDGothicNeo(ofSize: 12))
            ]))
        
        return .appendAttributedString(attributedTexts)
    }
}
