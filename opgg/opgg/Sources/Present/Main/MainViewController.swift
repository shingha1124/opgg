//
//  MainViewController.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import RxAppState
import RxSwift
import SnapKit
import UIKit

final class MainViewController: BaseViewController, View {
    
    private let topLayoutBox = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.tappedMatchs)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        view.do {
            $0.backgroundColor = .paleGrey
        }
        
        topLayoutBox.do {
            $0.backgroundColor = .clear
        }
        
        scrollView.do {
            $0.backgroundColor = .paleGrey
        }
        
        contentView.do {
            $0.backgroundColor = .paleGrey
            $0.axis = .vertical
        }
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(topLayoutBox)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        topLayoutBox.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.top)
            $0.bottom.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topLayoutBox.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
