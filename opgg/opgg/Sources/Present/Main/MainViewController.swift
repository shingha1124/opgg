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
    
    enum Constants {
        static let refreshScrollSize: CGFloat = 65
    }
    
    private let topLayoutBox = UIView()
    private let bottomLayoutBox = UIView()
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    private let topView = TopView()
    private let previousTierView = LeaguesView()
    private let summaryView = SummaryView()
    private let gamesView = GamesView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.viewDidLoad)
            .disposed(by: disposeBag)
        
        gamesView.updateHeight
            .map { [unowned self] height in
                let topOffset = self.topLayoutBox.frame.height
                let bottomOffset = self.bottomLayoutBox.frame.height
                return CGSize(width: 0, height: height + topOffset + bottomOffset)
            }
            .bind(to: scrollView.rx.contentSize)
            .disposed(by: disposeBag)
        
        scrollView.rx.didEndDragging
            .filter { [unowned self] _ in
                let maxScrollValue = self.scrollView.contentSize.height - self.scrollView.frame.height
                let diffVlue = self.scrollView.contentOffset.y - maxScrollValue
                return diffVlue > Constants.refreshScrollSize
            }
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { _ in }
            .bind(to: viewModel.action.didEndDragging)
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
//            $0.contentSize = CGSize(width: 0, height: 2000)
            $0.showsVerticalScrollIndicator = false
        }
        
        topView.do {
            $0.viewModel = viewModel?.subViewModel.topView
        }
        
        previousTierView.do {
            $0.viewModel = viewModel?.subViewModel.previousTier
        }
        
        summaryView.do {
            $0.viewModel = viewModel?.subViewModel.summary
        }
        
        gamesView.do {
            $0.viewModel = viewModel?.subViewModel.games
        }
        
        contentView.do {
            $0.axis = .vertical
            $0.spacing = 16
        }
    }
    
    override func layout() {
        super.layout()
        
        view.addSubview(topLayoutBox)
        view.addSubview(bottomLayoutBox)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(topView)
        contentView.addArrangedSubview(previousTierView)
        contentView.addArrangedSubview(summaryView)
        contentView.addArrangedSubview(gamesView)
        
        topLayoutBox.snp.makeConstraints {
            $0.top.equalTo(topLayoutGuide.snp.top)
            $0.bottom.equalTo(topLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        bottomLayoutBox.snp.makeConstraints {
            $0.top.equalTo(bottomLayoutGuide.snp.top)
            $0.bottom.equalTo(bottomLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(topLayoutBox.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomLayoutBox.snp.top)
        }
        
        contentView.snp.makeConstraints {
            $0.top.width.equalToSuperview()
            $0.bottom.equalTo(gamesView)
        }
    }
}
