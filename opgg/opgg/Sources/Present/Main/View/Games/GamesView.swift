//
//  GamesView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import RxRelay
import RxSwift
import UIKit

final class GamesView: BaseView, View {
    
    private let intrinsicTableView = IntrinsicTableView()

    private let dataSource = GamesTableDataSource()
    var disposeBag = DisposeBag()
    let updateHeight = PublishRelay<CGFloat>()
    
    func bind(to viewModel: GamesViewModel) {
        viewModel.state.cellViewModels
            .bind(onNext: dataSource.updateViewModels)
            .disposed(by: disposeBag)
        
        viewModel.state.reloadData
            .do { [unowned self] _ in
                self.intrinsicTableView.reloadData()
                self.intrinsicTableView.layoutIfNeeded()
            }
            .observe(on: MainScheduler.asyncInstance)
            .map { [unowned self] _ in
                self.frame.origin.y + self.intrinsicTableView.intrinsicContentSize.height
            }
            .bind(to: updateHeight)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        intrinsicTableView.do {
            $0.separatorStyle = .none
            $0.dataSource = dataSource
            $0.register(GamesTableViewCell.self, forCellReuseIdentifier: GamesTableViewCell.identifier)
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(intrinsicTableView)
        
        intrinsicTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(intrinsicTableView)
        }
    }
}
