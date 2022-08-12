//
//  GamesTableViewCell.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation

final class GamesTableViewCell: BaseTableViewCell, View {
    func bind(to viewModel: GamesTableViewCellModel) {
        
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.contentView.backgroundColor = .green.withAlphaComponent(0.5)
        }
    }
    
    override func layout() {
        super.layout()
    }
}
