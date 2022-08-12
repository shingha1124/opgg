//
//  LeaguesDataSource.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import UIKit

final class LeaguesScrollView: BaseView {
    private let scrollView = UIScrollView()
    private let contentView = UIStackView()
    
    var items = [LeagueCellViewModel]()
    
    override func attribute() {
        super.attribute()
                
        scrollView.do {
            $0.clipsToBounds = false
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
            $0.contentSize = CGSize(width: 2000, height: 100)
            $0.showsHorizontalScrollIndicator = false
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
    
    func reloadData() {
        contentView.removeFullyAllArrangedSubviews()
        let size = scrollView.frame.size
        items.forEach { viewModel in
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let cell = LeagueCellView(frame: frame)
            cell.viewModel = viewModel
            self.contentView.addArrangedSubview(cell)
        }
        self.scrollView.contentSize = CGSize(width: size.width * CGFloat(items.count), height: size.height)
    }
}
