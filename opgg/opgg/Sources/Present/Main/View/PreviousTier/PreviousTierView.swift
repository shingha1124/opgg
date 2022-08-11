//
//  RankView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class PreviousTierView: BaseView, View {
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: PreviousTierViewModel) {
        viewModel.state.previousTier
            .bind(onNext: { [unowned self] tiers in
                tiers.forEach { _ in
                    let frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
                    let cell = PreviousTierViewCell(frame: frame)
                    self.contentView.addArrangedSubview(cell)
                }
                self.scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(tiers.count), height: contentView.frame.height)
            })
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
                
        scrollView.do {
            $0.clipsToBounds = false
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
            $0.contentSize = CGSize(width: 2000, height: 100)
        }
        
        contentView.do {
            $0.axis = .horizontal
            $0.spacing = 0
        }
    }
    
    override func layout() {
        super.layout()
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        contentView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(100)
        }
    }
}
