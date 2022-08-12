//
//  MostChampionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/12.
//

import RxSwift
import UIKit

final class MostChampionView: BaseView, View {
    
    private let championImage = UIImageView()
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MostChampionViewModel) {
        championImage.setImage(viewModel.state.champion.imageURL)
    }
    
    override func attribute() {
        super.attribute()
        
        championImage.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 15
        }
    }
    
    override func layout() {
        super.layout()
        
        addSubview(championImage)
        
        championImage.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        snp.makeConstraints {
            $0.width.equalTo(championImage)
        }
    }
}
