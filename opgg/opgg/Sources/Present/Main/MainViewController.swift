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
    
    private let topView = TopView()
    private let previousTierView = LeaguesView()
    private let analysisView = AnalysisView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
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
            $0.backgroundColor = .clear
            $0.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16)
            $0.contentSize = CGSize(width: 0, height: 2000)
            $0.showsVerticalScrollIndicator = false
        }
        
        topView.do {
            $0.viewModel = viewModel?.subViewModel.topView
        }
        
        previousTierView.do {
            $0.viewModel = viewModel?.subViewModel.previousTier
        }
        
        analysisView.do {
            $0.viewModel = viewModel?.subViewModel.analysis
        }
        
        contentView.do {
            $0.axis = .vertical
            $0.spacing = 16
        }
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(topLayoutBox)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(topView)
        contentView.addArrangedSubview(previousTierView)
        contentView.addArrangedSubview(analysisView)
        
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
        
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalTo(analysisView)
        }
    }
}
