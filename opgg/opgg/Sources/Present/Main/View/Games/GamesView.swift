//
//  GamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import RxSwift
import UIKit

final class GamesView: BaseView, View {
    
    private let intrinsicTableView = IntrinsicTableView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: GamesViewModel) {
    }
    
    override func attribute() {
        super.attribute()
        
        intrinsicTableView.do {
            $0.register(GamesTableViewCell.self, forCellReuseIdentifier: GamesTableViewCell.identifier)
        }
    }
    
    override func layout() {
        super.layout()
    }
}
