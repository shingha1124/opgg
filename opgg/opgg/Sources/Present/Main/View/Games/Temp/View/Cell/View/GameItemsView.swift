//
//  GameItemsView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

final class GameItemsView: BaseView {
    
    private let stackView = UIStackView()
    private let itemImageViews = (0..<6).map { _ in UIImageView() }
    private let optionItemView = UIImageView()
    private let backgroundImage = UIImage(color: .paleGrey2)
    
    override func attribute() {
        super.attribute()
        
        stackView.do {
            $0.axis = .horizontal
            $0.spacing = 2
        }
        
        itemImageViews.forEach {
            $0.do {
                $0.image = backgroundImage
                $0.clipsToBounds = true
                $0.layer.cornerRadius = 3
            }
        }
        
        optionItemView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(stackView)
        
        itemImageViews.forEach {
            stackView.addArrangedSubview($0)
            
            $0.snp.makeConstraints {
                $0.width.height.equalTo(24)
            }
        }
        stackView.addArrangedSubview(optionItemView)
        
        stackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        optionItemView.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        snp.makeConstraints {
            $0.bottom.trailing.equalTo(stackView)
        }
    }
    
    func prepareForReuse() {
        itemImageViews.forEach {
            $0.image = backgroundImage
        }        
    }
    
    func setItems(_ items: [Item]) {
        var playerItems = items
        let optionItem = playerItems.removeLast()
        playerItems.enumerated().forEach {
            itemImageViews[$0].setImage($1.imageUrl)
        }
        
        optionItemView.setImage(optionItem.imageUrl)
    }
}
