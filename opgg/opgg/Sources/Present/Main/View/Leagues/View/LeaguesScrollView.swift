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
            $0.top.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(contentView)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        snp.makeConstraints {
            $0.height.equalTo(scrollView)
        }
    }
    
    func reloadData() {
        contentView.removeFullyAllArrangedSubviews()
        let size = scrollView.frame.size
        let cells = items.map { viewModel -> LeagueCellView in
            let cell = LeagueCellView()
            cell.viewModel = viewModel
            contentView.addArrangedSubview(cell)
            cell.snp.makeConstraints {
                $0.width.equalTo(size.width)
            }
            return cell
        }
        updateContentSize(cells[0])
    }
    
    private func updateContentSize(_ cell: UIView) {
        contentView.snp.remakeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(cell)
        }
        let width = scrollView.frame.size.width * CGFloat(items.count)
        scrollView.contentSize = CGSize(width: width, height: contentView.frame.height)
    }
}
