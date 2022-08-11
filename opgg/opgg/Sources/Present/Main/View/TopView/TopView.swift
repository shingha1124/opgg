//
//  TopView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import RxSwift
import UIKit

final class TopView: BaseView, View {
    var disposeBag = DisposeBag()
    
    private let thumbnail = UIImageView()
    private let title = UILabel()
    private let refreshButton = UIButton()
    
    func bind(to viewModel: MainViewModel) {
        
    }
    
    override func attribute() {
        super.attribute()
        
        self.do {
            $0.backgroundColor = .black
        }
        
        thumbnail.do {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 44
            $0.clipsToBounds = true
        }
        
        title.do {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.text = "OPGG"
        }
        
        refreshButton.do {
            $0.backgroundColor = .softBlue
            $0.setTitle("전적갱신", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14)
            $0.layer.cornerRadius = 20
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(thumbnail)
        addSubview(title)
        addSubview(refreshButton)
        
        thumbnail.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(88)
        }
        
        title.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(thumbnail.snp.trailing).offset(16)
        }
        
        refreshButton.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(16)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(97)
            $0.height.equalTo(40)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(thumbnail)
        }
    }
}
