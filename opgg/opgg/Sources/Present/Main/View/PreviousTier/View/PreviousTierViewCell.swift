//
//  PreviousTierViewCell.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import Foundation
import UIKit

final class PreviousTierViewCell: BaseView {
    
    private let contentView = UIView()
    
    override func attribute() {
        super.attribute()
        contentView.do {
            $0.backgroundColor = .black
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-8)
        }
        
        snp.makeConstraints {
            $0.width.equalTo(frame.width)
            $0.height.equalTo(frame.height)
        }
    }
}
