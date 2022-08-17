//
//  TopView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import RxSwift
import UIKit

final class TopView: BaseView, View {
    private let thumbnail = UIImageView()
    private let title = UILabel()
    private let updateButton = UIButton()
    private let levelLabel = PaddingLabel()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: TopViewModel) {
        viewModel.state.profileImageURL
            .bind(onNext: thumbnail.setImage)
            .disposed(by: disposeBag)
        
        viewModel.state.level
            .map { String($0) }
            .bind(to: levelLabel.rx.text)
            .disposed(by: disposeBag)
        
        updateButton.rx.tap
            .bind(to: viewModel.action.update)
            .disposed(by: disposeBag)
    }
    
    override func attribute() {
        super.attribute()
        
        thumbnail.do {
            $0.backgroundColor = .red
            $0.layer.cornerRadius = 44
            $0.clipsToBounds = true
        }
        
        title.do {
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.text = "OPGG"
        }
        
        updateButton.do {
            $0.backgroundColor = .softBlue
            $0.setTitle("Update".localized(), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
            $0.layer.cornerRadius = 20
        }
        
        levelLabel.do {
            $0.backgroundColor = .darkgrey
            $0.font = .systemFont(ofSize: 12, weight: .regular)
            $0.textColor = .white
            $0.padding = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(thumbnail)
        addSubview(levelLabel)
        addSubview(title)
        addSubview(updateButton)
        
        thumbnail.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(88)
        }
        
        levelLabel.snp.makeConstraints {
            $0.bottom.trailing.equalTo(thumbnail)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(thumbnail)
            $0.leading.equalTo(thumbnail.snp.trailing).offset(16)
        }
        
        updateButton.snp.makeConstraints {
            $0.leading.equalTo(thumbnail.snp.trailing).offset(16)
            $0.bottom.equalTo(thumbnail)
            $0.width.equalTo(97)
            $0.height.equalTo(40)
        }
        
        snp.makeConstraints {
            $0.bottom.equalTo(thumbnail).offset(24)
        }
    }
}
